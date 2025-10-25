import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

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
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isTyping = false;
  bool _isLoading = true;
  bool _isListening = false;
  String _selectedLanguage = '';
  String _selectedLanguageCode = '';
  String _currentSessionLanguageCode = ''; // For temporary language changes
  bool _voiceEnabled = false;
  int _dailyMessageCount = 0;
  String _sessionId = '';
  String _userName = ''; // Store user's name
  String? _currentRecordingPath;
  String _recognizedText = ''; // Store real-time recognized text

  // API Configuration
  static const String apiBaseUrl = 'http://127.0.0.1:8000';

  // Color constants
  static const Color primaryPurple = Color(0xFF7A60D6);
  static const Color secondaryPurple = Color(0xFF4157FF);
  static const Color chatBubbleColor = Color(0xFFF5F5F5);

  // South African official languages
  final Map<String, String> _saLanguages = {
    'en': 'English',
    'af': 'Afrikaans',
    'zu': 'isiZulu',
    'xh': 'isiXhosa',
    'st': 'Sesotho',
    'nso': 'Sepedi',
    'tn': 'Setswana',
    'ss': 'siSwati',
    've': 'Tshivenda',
    'ts': 'Xitsonga',
    'nr': 'isiNdebele',
  };

  // Greeting messages in different languages with {name} placeholder
  final Map<String, String> _greetings = {
    'en': 'Hi {name}! How can I help you today?',
    'af': 'Hallo {name}! Hoe kan ek jou vandag help?',
    'zu': 'Sawubona {name}! Ngingakusiza kanjani namuhla?',
    'xh': 'Molo {name}! Ndingakunceda njani namhlanje?',
    'st': 'Dumela {name}! Nka u thusa jwang kajeno?',
    'nso': 'Thobela {name}! Nka go thuša bjang lehono?',
    'tn': 'Dumela {name}! Nka go thusa jang gompieno?',
    'ss': 'Sawubona {name}! Ngingakusita njani namuhla?',
    've': 'Ndaa {name}! Ndi nga ni thusa hani namusi?',
    'ts': 'Xewani {name}! Ndzi nga ni pfuna njhani namuntlha?',
    'nr': 'Lotjhani {name}! Ngingalikusiza njani lamuhla?',
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

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _flutterTts.stop();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
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
        _currentSessionLanguageCode = _selectedLanguageCode; // Initialize session language
        _selectedLanguage = data['languageName'] ?? 'English';
        _voiceEnabled = data['voiceEnabled'] ?? false;
        _userName = data['name'] ?? 'Friend'; // Get user's name
        _isLoading = false;
      });

      // Set TTS language
      await _flutterTts.setLanguage(_currentSessionLanguageCode);

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
      final greetingTemplate = _greetings[_currentSessionLanguageCode] ?? _greetings['en']!;
      final greeting = greetingTemplate.replaceAll('{name}', _userName);

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

  Future<void> _sendMessage({String? voiceText, String? audioPath}) async {
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
      'audioPath': audioPath, // Store audio path if available
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

      // Send message to Gemini backend using current session language
      final response = await http.post(
        Uri.parse('$apiBaseUrl/api/gemini/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': text,
          'language': _currentSessionLanguageCode,
          'session_id': _sessionId,
          'user_name': _userName,  // Send user's name for personalized responses
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

        _scrollToBottom();

        // Speak the response if voice is enabled
        if (_voiceEnabled) {
          await _flutterTts.speak(botResponse);
        }
      } else {
        throw Exception('Failed to get response from chatbot');
      }
    } catch (e) {
      setState(() {
        _isTyping = false;
      });
      _showError('Error: ${e.toString()}');
    }
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      // Stop listening and recording
      await _speech.stop();
      if (_currentRecordingPath != null) {
        await _audioRecorder.stop();
        // Send the message with both text and audio
        await _sendMessage(voiceText: _recognizedText, audioPath: _currentRecordingPath);
        _currentRecordingPath = null;
        _recognizedText = '';
      }
      setState(() {
        _isListening = false;
      });
    } else {
      // Start listening and recording
      final hasPermission = await _audioRecorder.hasPermission();
      if (!hasPermission) {
        _showError('Microphone permission denied');
        return;
      }

      bool available = await _speech.initialize();
      if (!available) {
        _showError('Speech recognition not available');
        return;
      }

      // Create audio file path
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
      _currentRecordingPath = '${directory.path}/$fileName';

      // Start recording
      await _audioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: _currentRecordingPath!,
      );

      setState(() {
        _isListening = true;
        _recognizedText = '';
      });

      // Start speech recognition with real-time updates
      await _speech.listen(
        onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
            _controller.text = _recognizedText; // Show in text field
          });
        },
        localeId: _currentSessionLanguageCode,
        listenMode: stt.ListenMode.confirmation,
      );
    }
  }

  Future<void> _playAudio(String audioPath) async {
    try {
      await _audioPlayer.play(DeviceFileSource(audioPath));
    } catch (e) {
      _showError('Error playing audio: ${e.toString()}');
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
  }

  Future<void> _toggleVoice() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final newVoiceState = !_voiceEnabled;

      await _firestore.collection('users').doc(user.uid).update({
        'voiceEnabled': newVoiceState,
      });

      setState(() {
        _voiceEnabled = newVoiceState;
      });

      if (!newVoiceState) {
        await _flutterTts.stop();
      }
    } catch (e) {
      _showError('Error toggling voice: ${e.toString()}');
    }
  }

  Future<void> _stopSpeaking() async {
    await _flutterTts.stop();
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Change Language (This Session Only)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryPurple,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This will not save to your profile',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _saLanguages.length,
                itemBuilder: (context, index) {
                  final languageCode = _saLanguages.keys.elementAt(index);
                  final languageName = _saLanguages[languageCode]!;
                  final isSelected = languageCode == _currentSessionLanguageCode;

                  return ListTile(
                    leading: Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color: isSelected ? primaryPurple : Colors.grey,
                    ),
                    title: Text(
                      languageName,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? primaryPurple : Colors.black87,
                      ),
                    ),
                    onTap: () async {
                      setState(() {
                        _currentSessionLanguageCode = languageCode;
                      });
                      await _flutterTts.setLanguage(languageCode);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLimitDialog() {
    final message = _limitMessages[_currentSessionLanguageCode] ?? _limitMessages['en']!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Daily Limit Reached'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
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
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryPurple),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dysphagia Care Assistant',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryPurple,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildMessageList()),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final remaining = 5 - _dailyMessageCount;
    final currentLanguageName = _saLanguages[_currentSessionLanguageCode] ?? 'English';
    final isLanguageChanged = _currentSessionLanguageCode != _selectedLanguageCode;

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Chat in $currentLanguageName',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: primaryPurple,
                          ),
                        ),
                        if (isLanguageChanged) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.edit,
                            size: 14,
                            color: secondaryPurple,
                          ),
                        ],
                      ],
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
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.language,
                      color: primaryPurple,
                    ),
                    onPressed: _showLanguagePicker,
                    tooltip: 'Change language',
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
            ],
          ),
          if (isLanguageChanged)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: secondaryPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Temporary language change - not saved',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
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
    final audioPath = message['audioPath'] as String?;

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
            // Audio playback for user messages with recordings
            if (isUser && audioPath != null) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.play_arrow, size: 20),
                    color: primaryPurple,
                    onPressed: () => _playAudio(audioPath),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    tooltip: 'Play your question',
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.stop, size: 20),
                    color: primaryPurple,
                    onPressed: _stopAudio,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    tooltip: 'Stop',
                  ),
                ],
              ),
            ],
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
                hintText: _isListening ? 'Listening...' : 'Type a Message...',
                hintStyle: TextStyle(
                  color: _isListening ? secondaryPurple : Colors.grey[400],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: _isListening 
                    ? primaryPurple.withOpacity(0.05)
                    : chatBubbleColor,
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
              gradient: LinearGradient(
                colors: _isListening
                    ? [Colors.red, Colors.redAccent]
                    : [primaryPurple, secondaryPurple],
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