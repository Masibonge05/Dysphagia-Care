
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
          // Enable swipe navigation
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              // Swipe left to go to next page
              onNext();
            } else if (details.primaryVelocity! > 0) {
              // Swipe right to go back to previous page
              onPrevious();
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
                      ElevatedButton(
                        onPressed: onNext, // Changed from onSkip to onNext
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        ),
                        child: const Text('Skip'),
                      ),
                    ],
                  ),
                ),
                
                // Main content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        
                        const SizedBox(height: 40),
                        
                        // Grandpa illustration
                        Container(
                          width: 300,
                          height: 300,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/oldman.png',
                              fit: BoxFit.cover,
                              width: 300,
                              height: 300,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 60),
                        
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
                      ],
                    ),
                  ),
                ),
                
                // Page indicator at bottom
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
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