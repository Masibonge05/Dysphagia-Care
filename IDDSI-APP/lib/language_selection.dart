import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? selectedLanguage;
  String? selectedLanguageCode;
  bool showLanguageList = false;
  bool isLoading = true;
  bool isSaving = false;

  // List of South African languages (11 official languages)
  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'af', 'name': 'Afrikaans'},
    {'code': 'nr', 'name': 'isiNdebele'},
    {'code': 'xh', 'name': 'isiXhosa'},
    {'code': 'zu', 'name': 'isiZulu'},
    {'code': 'nso', 'name': 'Sepedi'},
    {'code': 'st', 'name': 'Sesotho'},
    {'code': 'tn', 'name': 'Setswana'},
    {'code': 'ss', 'name': 'siSwati'},
    {'code': 've', 'name': 'Tshivenda'},
    {'code': 'ts', 'name': 'Xitsonga'},
  ];

  List<Map<String, String>> filteredLanguages = [];

  @override
  void initState() {
    super.initState();
    filteredLanguages = languages;
    _searchController.addListener(_filterLanguages);
    _checkExistingLanguage();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Check if user has already selected a language
  Future<void> _checkExistingLanguage() async {
    try {
      // Get current user
      final user = _auth.currentUser;

      if (user == null) {
        // User not logged in
        if (mounted) {
          setState(() {
            isLoading = false;
          });
          _showError('Please login first');
        }
        return;
      }

      // Check if user document exists and has language selected
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        final data = userDoc.data();
        if (data != null &&
            data.containsKey('languageCode') &&
            data['languageCode'] != null) {
          // User already has a language selected, navigate to home
          if (mounted) {
            _navigateToHome();
          }
          return;
        }
      }

      // No language selected yet, show selection screen
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        _showError('Error checking language: ${e.toString()}');
      }
    }
  }

  void _filterLanguages() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredLanguages = languages;
        showLanguageList = false;
      } else {
        filteredLanguages = languages
            .where(
                (language) => language['name']!.toLowerCase().contains(query))
            .toList();
        showLanguageList = true;
      }
    });
  }

  void _selectLanguage(String languageName, String languageCode) {
    setState(() {
      selectedLanguage = languageName;
      selectedLanguageCode = languageCode;
      _searchController.text = languageName;
      showLanguageList = false;
    });
  }

  Future<void> _getStarted() async {
    if (selectedLanguage == null || selectedLanguageCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a language first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Get current user
    final user = _auth.currentUser;

    if (user == null) {
      _showError('Please login first');
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      // Save language to Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'languageCode': selectedLanguageCode,
        'languageName': selectedLanguage,
        'voiceEnabled': false, // Default voice setting
        'dailyMessageCount': 0, // Initialize message count
        'lastResetDate': DateTime.now().toIso8601String(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Language saved: $selectedLanguage'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1),
          ),
        );

        // Navigate to HomePage
        _navigateToHome();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
        _showError('Error saving language: ${e.toString()}');
      }
    }
  }

  void _navigateToHome() {
    final user = _auth.currentUser;
    if (user == null) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          userName: user.displayName ?? 'User',
          currentLevel: 3, // You can fetch this from Firestore if needed
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show loading screen while checking for existing language
    if (isLoading) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF00529A),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),

                    // Title
                    const Text(
                      'Choose Language\nFor ChatBot',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00529A),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Search Bar
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF00529A),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        enabled: !isSaving,
                        decoration: const InputDecoration(
                          hintText: 'Search language...',
                          hintStyle: TextStyle(
                            color: Color(0xFF00529A),
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF00529A),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                        style: const TextStyle(
                          color: Color(0xFF00529A),
                          fontSize: 16,
                        ),
                      ),
                    ),

                    // Language List (appears when searching)
                    if (showLanguageList) ...[
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: filteredLanguages.length,
                          itemBuilder: (context, index) {
                            final language = filteredLanguages[index];

                            return ListTile(
                              title: Text(
                                language['name']!,
                                style: const TextStyle(
                                  color: Color(0xFF00529A),
                                  fontSize: 16,
                                ),
                              ),
                              onTap: () => _selectLanguage(
                                language['name']!,
                                language['code']!,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            );
                          },
                        ),
                      ),
                    ],

                    const SizedBox(height: 30),

                    // Robot Avatar Section
                    SizedBox(
                      height: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Robot Avatar - Larger Size
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.asset(
                              'assets/images/chat.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00529A),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.smart_toy,
                                    size: 80,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Text below avatar - dynamic based on selection
                          Text(
                            selectedLanguage != null
                                ? '"Ready to chat in $selectedLanguage"'
                                : '"Let\'s chat in your chosen language"',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF00529A),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Get Started Button
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00529A),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 5,
                        ),
                        onPressed: isSaving ? null : _getStarted,
                        child: isSaving
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}