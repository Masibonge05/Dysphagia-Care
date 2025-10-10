import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isTyping = false;
  bool _isLoading = true;
  bool _isListening = false;
  String _selectedLanguage = '';
  String _selectedLanguageCode = '';
  bool _voiceEnabled = false;
  int _dailyMessageCount = 0;
  String _sessionId = '';

  // API Configuration
  static const String apiBaseUrl = 'http://127.0.0.1:8000';

  // Color constants
  static const Color primaryPurple = Color(0xFF7A60D6);
  static const Color secondaryPurple = Color(0xFF4157FF);
  static const Color chatBubbleColor = Color(0xFFF5F5F5);

  // Greeting messages in different languages
  final Map<String, String> _greetings = {
    'en': 'Hello! How can I help you today?',
    'af': 'Hallo! Hoe kan ek jou vandag help?',
    'zu': 'Sawubona! Ngingakusiza kanjani namuhla?',
    'xh': 'Molo! Ndingakunceda njani namhlanje?',
    'st': 'Dumela! Nka u thusa jwang kajeno?',
    'nso': 'Thobela! Nka go thuša bjang lehono?',
    'tn': 'Dumela! Nka go thusa jang gompieno?',
    'ss': 'Sawubona! Ngingakusita njani namuhla?',
    've': 'Ndaa! Ndi nga ni thusa hani namusi?',
    'ts': 'Xewani! Ndzi nga ni pfuna njhani namuntlha?',
    'nr': 'Lotjhani! Ngingalikusiza njani lamuhla?',
  };

  // Limit messages
  final Map<String, String> _limitMessages = {
    'en': 'You have reached your daily limit of 5 messages. Please try again tomorrow.',
    'af': 'Jy het jou daaglikse limiet van 5 boodskappe bereik. Probeer asseblief môre weer.',
    'zu': 'Ufinyelele emkhawulweni wakho wansuku zonke wemilayezo emi-5. Sicela uzame kusasa.',
    'xh': 'Ufikelele kumda wakho wemihla ngemihla weemyalezo ezi-5. Nceda uzame kwakhona ngomso.',
    'st': 'U fihlile moeding wa hao wa letsatsi ka letsatsi wa melaetsa e 5. Ka kopo leka hape hosane.',
    'nso': 'O fihlile tekanelong ya gago ya letšatši ka letšatši ya melaetša ye 5. Hle leka gape gosasa.',
    'tn': 'O fitlhile moleelo wa gago wa letsatsi ka letsatsi wa melaetsa e 5. Tsweetswee leka gape kamoso.',
    'ss': 'Ufinyele emkhawulweni wakho wemalanga wemilayeto lemi-5. Sicela uzame ngakusasa.',
    've': 'No swika kha ndinganyiso yanu ya ḓuvha ḽiṅwe na ḽiṅwe ya mafhungo a 5. Ni humbele u lingedza matshelo.',
    'ts': 'Mi fikele exihelelweni xa n\'wina xa siku rin\'wana na rin\'wana xa switsundzuxo swa 5. Kombela mi ringeta namuntlha.',
    'nr': 'Ufinyelele emkhawulweni wakho welanga nemilanga yemiyalezo emi-5. Sicela uzame ngakusasa.',
  };

  @override
  void initState() {
    super.initState();
    _sessionId = DateTime.now().millisecondsSinceEpoch.toString();
    _initializeTTS();
    _initializeSpeech();
    _loadUserPreferences();
  }

  Future<void> _initializeTTS() async {
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> _initializeSpeech() async {
    await _speech.initialize();
  }

  Future<void> _loadUserPreferences() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          _showError('Please login first');
        }
        return;
      }

      // Load user preferences from Firestore
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists || userDoc.data() == null) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          _showError('Please select your language first');
        }
        return;
      }

      final data = userDoc.data()!;

      // Check if daily limit needs reset
      final lastResetDate = data['lastResetDate'] != null
          ? DateTime.parse(data['lastResetDate'])
          : DateTime.now();
      final now = DateTime.now();
      final needsReset = now.day != lastResetDate.day ||
          now.month != lastResetDate.month ||
          now.year != lastResetDate.year;

      if (needsReset) {
        // Reset daily count
        await _firestore.collection('users').doc(user.uid).update({
          'dailyMessageCount': 0,
          'lastResetDate': DateTime.now().toIso8601String(),
        });
        setState(() {
          _dailyMessageCount = 0;
        });
      } else {
        setState(() {
          _dailyMessageCount = data['dailyMessageCount'] ?? 0;
        });
      }

      setState(() {
        _selectedLanguageCode = data['languageCode'] ?? 'en';
        _selectedLanguage = data['languageName'] ?? 'English';
        _voiceEnabled = data['voiceEnabled'] ?? false;
        _isLoading = false;
      });

      // Set TTS language
      await _flutterTts.setLanguage(_selectedLanguageCode);

      // Add greeting message
      _addGreetingMessage();
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showError('Error loading preferences: ${e.toString()}');
      }
    }
  }

  void _addGreetingMessage() {
    Future.delayed(const Duration(milliseconds: 500), () {
      final greeting = _greetings[_selectedLanguageCode] ?? _greetings['en']!;

      setState(() {
        _messages.add({
          'message': greeting,
          'isUser': false,
          'timestamp': DateTime.now(),
        });
      });

      _scrollToBottom();
    });
  }

  Future<void> _sendMessage({String? voiceText}) async {
    final text = voiceText ?? _controller.text.trim();
    if (text.isEmpty) return;

    // Check daily limit
    if (_dailyMessageCount >= 5) {
      _showLimitDialog();
      return;
    }

    _controller.clear();

    final userMessage = {
      'message': text,
      'isUser': true,
      'timestamp': DateTime.now(),
    };

    setState(() {
      _messages.add(userMessage);
      _isTyping = true;
    });

    _scrollToBottom();

    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      // Increment message count
      await _firestore.collection('users').doc(user.uid).update({
        'dailyMessageCount': FieldValue.increment(1),
      });

      setState(() {
        _dailyMessageCount++;
      });

      // Send message to Gemini backend
      final response = await http.post(
        Uri.parse('$apiBaseUrl/api/gemini/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': text,
          'language': _selectedLanguageCode,
          'session_id': _sessionId,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final botResponse = responseData['response'] ??
            'Sorry, I could not process your request.';

        final botMessage = {
          'message': botResponse,
          'isUser': false,
          'timestamp': DateTime.now(),
        };

        setState(() {
          _isTyping = false;
          _messages.add(botMessage);
        });

        // Speak response if voice enabled
        if (_voiceEnabled) {
          await _flutterTts.speak(botResponse);
        }

        // Save to chat history
        await _saveChatMessage(user.uid, userMessage);
        await _saveChatMessage(user.uid, botMessage);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isTyping = false;
        _messages.add({
          'message': 'Sorry, I could not connect to the server. Please check your connection.',
          'isUser': false,
          'timestamp': DateTime.now(),
        });
      });
    }

    _scrollToBottom();
  }

  Future<void> _saveChatMessage(String userId, Map<String, dynamic> message) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('chatHistory')
          .add({
        'message': message['message'],
        'isUser': message['isUser'],
        'timestamp': message['timestamp'].toIso8601String(),
      });
    } catch (e) {
      print('Error saving chat message: $e');
    }
  }

  void _showLimitDialog() {
    final limitMsg = _limitMessages[_selectedLanguageCode] ?? _limitMessages['en']!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Daily Limit Reached'),
        content: Text(limitMsg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleVoice() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final newValue = !_voiceEnabled;

    await _firestore.collection('users').doc(user.uid).update({
      'voiceEnabled': newValue,
    });

    setState(() {
      _voiceEnabled = newValue;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(newValue ? 'Voice enabled' : 'Voice disabled'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _toggleListening() async {
    if (!_voiceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable voice first'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_isListening) {
      await _speech.stop();
      setState(() {
        _isListening = false;
      });
    } else {
      setState(() {
        _isListening = true;
      });

      await _speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            _sendMessage(voiceText: result.recognizedWords);
            setState(() {
              _isListening = false;
            });
          }
        },
        localeId: _selectedLanguageCode,
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      );
    }
  }

  Future<void> _stopSpeaking() async {
    await _flutterTts.stop();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _flutterTts.stop();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF7A60D6),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildChatScreen(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'IDDSI Chat Bot',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      backgroundColor: primaryPurple,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  Widget _buildChatScreen() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildChatHeader(),
          Expanded(child: _buildMessageList()),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatHeader() {
    final remaining = 5 - _dailyMessageCount;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chat in $_selectedLanguage',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: primaryPurple,
                  ),
                ),
                Text(
                  '$remaining messages remaining today',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              _voiceEnabled ? Icons.volume_up : Icons.volume_off,
              color: primaryPurple,
            ),
            onPressed: _toggleVoice,
            tooltip: 'Toggle voice',
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length + (_isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _messages.length && _isTyping) {
          return _buildTypingIndicator();
        }
        return _buildMessageBubble(_messages[index]);
      },
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: chatBubbleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(1),
            _buildDot(2),
            _buildDot(3),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: 6,
      width: 6,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(3),
      ),
      child: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 300 * index),
        builder: (context, double value, child) {
          return Transform.scale(
            scale: 0.5 + (value * 0.5),
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isUser = message['isUser'] as bool;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser
                    ? primaryPurple.withOpacity(0.1)
                    : chatBubbleColor,
                borderRadius: BorderRadius.circular(20),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              child: Text(
                message['message'],
                style: TextStyle(
                  color: isUser ? primaryPurple : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
            // Voice controls for bot messages
            if (!isUser && _voiceEnabled) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.play_circle_filled, size: 24),
                    color: primaryPurple,
                    onPressed: () => _flutterTts.speak(message['message']),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.stop_circle, size: 24),
                    color: primaryPurple,
                    onPressed: _stopSpeaking,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a Message...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: chatBubbleColor,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          // Voice input button
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  primaryPurple,
                  secondaryPurple,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              icon: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                color: Colors.white,
              ),
              onPressed: _toggleListening,
            ),
          ),
          const SizedBox(width: 8),
          // Send button
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [primaryPurple, secondaryPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => _sendMessage(),
            ),
          ),
        ],
      ),
    );
  }
}