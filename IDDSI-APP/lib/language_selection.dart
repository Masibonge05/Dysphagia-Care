import 'package:flutter/material.dart';
import 'home_page.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  final TextEditingController _searchController = TextEditingController();
  String? selectedLanguage;
  bool showLanguageList = false;

  // List of South African languages (11 official languages + commonly spoken ones)
  final List<Map<String, String>> languages = [
    // Official South African Languages
    {'code': 'af', 'name': 'Afrikaans'},
    {'code': 'en', 'name': 'English'},
    {'code': 'nr', 'name': 'isiNdebele (Southern Ndebele)'},
    {'code': 'xh', 'name': 'isiXhosa'},
    {'code': 'zu', 'name': 'isiZulu'},
    {'code': 'nso', 'name': 'Sepedi (Northern Sotho)'},
    {'code': 'st', 'name': 'Sesotho (Southern Sotho)'},
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
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

  void _selectLanguage(String languageName) {
    setState(() {
      selectedLanguage = languageName;
      _searchController.text = languageName;
      showLanguageList = false;
    });
  }

  void _getStarted() {
    if (selectedLanguage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a language first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Navigate to HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(
          userName: 'User', // You can modify this to get the actual user name
          currentLevel: 3, // Default level, you can modify this as needed
        ),
      ),
    );

    // Alternative: If you want to keep the SnackBar for testing, uncomment below:
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Selected language: $selectedLanguage'),
    //     backgroundColor: Colors.green,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
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
                              onTap: () => _selectLanguage(language['name']!),
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

                          // Text below avatar
                          const Text(
                            '"Let\'s chat in your chosen language"',
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                        onPressed: _getStarted,
                        child: const Text(
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
