import 'package:flutter/material.dart';

class Welcome4 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  
  // Constructor that takes callback functions for navigation
  const Welcome4({
    super.key, 
    required this.onNext, 
    required this.onPrevious
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onNext, // Tap to go to next page (Welcome5)
          // Enable swipe navigation
          onHorizontalDragEnd: (details) {
            // Swipe right to go back to previous page (Welcome3)
            if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
              onPrevious();
            }
            // Swipe left to go to next page
            else if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
              onNext();
            }
          },
          child: SafeArea(
            child: Column(
              children: [
                // Skip button at top right
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signin');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2196F3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Main content - wrapped in Expanded with SingleChildScrollView
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          
                          // Main heading
                          const Text(
                            'Swallowing gets harder\nas we age',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B365D),
                            ),
                          ),
                          
                          const SizedBox(height: 30),
                          
                          // Grandpa illustration - reduced size for smaller screens
                          Container(
                            width: 250,
                            height: 250,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/oldman.png',
                                fit: BoxFit.cover,
                                width: 250,
                                height: 250,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Subtitle description
                          const Text(
                            'Many elders struggle\nsilently. This app helps them\neat and drink safely.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Page indicator at bottom
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white54),
                          color: Colors.transparent,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white54),
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}