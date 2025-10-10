import 'package:flutter/material.dart';

class Welcome3 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const Welcome3({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // Changed from translucent to opaque
        onTap: onNext, // Tap to go to next page (Welcome4)
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null) {
            if (details.primaryVelocity! > 0) {
              onPrevious(); // Swipe right to go to previous page (Welcome2)
            } else if (details.primaryVelocity! < 0) {
              onNext(); // Swipe left to go to next page (Welcome4)
            }
          }
        },
        child: Stack(
          children: [
            // Full-screen background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),

            // Skip button at top right with light blue background and curved corners
            Positioned(
              top: 50,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A90E2), // light blue
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Push down from top
                    SizedBox(height: screenHeight * 0.1),

                    // Title: two lines, bold, midnight blue, lowercase "doesn't"
                    const Text(
                      "Sometimes, food\ndoesn't go down right",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF191970), // Midnight Blue
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // Spacer to push image down a bit
                    SizedBox(height: screenHeight * 0.02),

                    // Kid image (larger)
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/images/kid.png',
                          fit: BoxFit.contain,
                          width: screenWidth * 0.98,
                        ),
                      ),
                    ),

                    // Description text under the image in three lines
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Dysphagia means having\n'
                        'trouble swallowing.\n'
                        'This app helps you stay safe.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Bottom padding
                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}