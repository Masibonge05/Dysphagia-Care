import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _showWelcomeScreen = true;
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  String _selectedLanguage = '';
  String _selectedLanguageCode = '';

  // API Configuration
  static const String apiBaseUrl = 'http://127.0.0.1:8000';
  String _sessionId = '';

  // Color constants
  static const Color primaryPurple = Color(0xFF7A60D6);
  static const Color secondaryPurple = Color(0xFF4157FF);
  static const Color chatBubbleColor = Color(0xFFF5F5F5);

  // South African official languages
  final Map<String, String> _languages = {
    'English': 'en',
    'Afrikaans': 'af',
    'isiZulu': 'zu',
    'isiXhosa': 'xh',
    'Sesotho': 'st',
    'Sepedi': 'nso',
    'Setswana': 'tn',
    'siSwati': 'ss',
    'Tshivenda': 've',
    'Xitsonga': 'ts',
    'isiNdebele': 'nr',
  };

  // Greeting messages in different languages
  final Map<String, Map<String, String>> _greetings = {
    'en': {
      'greeting': 'Hello! How can I help you today?',
      'language_name': 'English'
    },
    'af': {
      'greeting': 'Hallo! Hoe kan ek jou vandag help?',
      'language_name': 'Afrikaans'
    },
    'zu': {
      'greeting': 'Sawubona! Ngingakusiza kanjani namuhla?',
      'language_name': 'isiZulu'
    },
    'xh': {
      'greeting': 'Molo! Ndingakunceda njani namhlanje?',
      'language_name': 'isiXhosa'
    },
    'st': {
      'greeting': 'Dumela! Nka u thusa jwang kajeno?',
      'language_name': 'Sesotho'
    },
    'nso': {
      'greeting': 'Thobela! Nka go thuša bjang lehono?',
      'language_name': 'Sepedi'
    },
    'tn': {
      'greeting': 'Dumela! Nka go thusa jang gompieno?',
      'language_name': 'Setswana'
    },
    'ss': {
      'greeting': 'Sawubona! Ngingakusita njani namuhla?',
      'language_name': 'siSwati'
    },
    've': {
      'greeting': 'Ndaa! Ndi nga ni thusa hani namusi?',
      'language_name': 'Tshivenda'
    },
    'ts': {
      'greeting': 'Xewani! Ndzi nga ni pfuna njhani namuntlha?',
      'language_name': 'Xitsonga'
    },
    'nr': {
      'greeting': 'Lotjhani! Ngingalikusiza njani lamuhla?',
      'language_name': 'isiNdebele'
    },
  };

  @override
  void initState() {
    super.initState();
    _generateSessionId();
  }

  void _generateSessionId() {
    _sessionId = DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = _controller.text.trim();
    _controller.clear();

    setState(() {
      _messages.add({
        'message': userMessage,
        'isUser': true,
      });
      _isTyping = true;
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    try {
      // Send message to backend API
      final response = await http.post(
        Uri.parse('$apiBaseUrl/api/session/$_sessionId/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': userMessage,
          'language': _selectedLanguageCode,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final botResponse = responseData['response'] ??
            'Sorry, I could not process your request.';

        setState(() {
          _isTyping = false;
          _messages.add({
            'message': botResponse,
            'isUser': false,
          });
        });
      } else {
        setState(() {
          _isTyping = false;
          _messages.add({
            'message': 'Sorry, there was an error processing your request.',
            'isUser': false,
          });
        });
      }
    } catch (e) {
      setState(() {
        _isTyping = false;
        _messages.add({
          'message':
              'Sorry, I could not connect to the server. Please check your connection.',
          'isUser': false,
        });
      });
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _showLanguageSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Your Language'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                final languageName = _languages.keys.elementAt(index);
                final languageCode = _languages.values.elementAt(index);

                return ListTile(
                  title: Text(languageName),
                  onTap: () {
                    _selectLanguage(languageName, languageCode);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _selectLanguage(String language, String languageCode) {
    setState(() {
      _selectedLanguage = language;
      _selectedLanguageCode = languageCode;
      _showWelcomeScreen = false;
      _messages.clear();
    });

    // Add greeting message from bot
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add({
          'message': _greetings[languageCode]!['greeting']!,
          'isUser': false,
        });
      });

      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    });
  }

  void _changeLanguage() {
    _showLanguageSelection();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
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
                child: const Icon(Icons.arrow_back_ios,
                    color: Colors.black, size: 20),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
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
      ),
      body: _showWelcomeScreen ? _buildWelcomeScreen() : _buildChatScreen(),
    );
  }

  Widget _buildWelcomeScreen() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
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
                const Text(
                  'Choose Your Language',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: primaryPurple,
                  ),
                ),
                TextButton(
                  onPressed: _showLanguageSelection,
                  style: TextButton.styleFrom(
                    foregroundColor: primaryPurple,
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Select Language',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar Image
                Container(
                  width: 120,
                  height: 120,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryPurple.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/chat.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback to icon if image not found
                        return Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: primaryPurple.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.smart_toy,
                            size: 60,
                            color: primaryPurple,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Text(
                  "Welcome to IDDSI Chatbot",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Select your preferred language to start chatting",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _showLanguageSelection,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Choose Language',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatScreen() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
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
                Text(
                  'Chat in $_selectedLanguage',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: primaryPurple,
                  ),
                ),
                TextButton(
                  onPressed: _changeLanguage,
                  style: TextButton.styleFrom(
                    foregroundColor: primaryPurple,
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Change Language',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          Container(
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
                const SizedBox(width: 12),
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
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
        builder: (context, value, child) {
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? primaryPurple.withOpacity(0.1) : chatBubbleColor,
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
    );
  }
}

class IDDSIChatbotApp extends StatelessWidget {
  const IDDSIChatbotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF7A60D6),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7A60D6),
          primary: const Color(0xFF7A60D6),
        ),
      ),
      home: const ChatbotPage(),
    );
  }
}

void main() {
  runApp(const IDDSIChatbotApp());
}
