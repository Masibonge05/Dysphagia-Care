import 'package:flutter/material.dart';
// Make sure you have dotted_border in pubspec.yaml:
//   dotted_border: ^2.0.0
import 'package:dotted_border/dotted_border.dart';

class Level6TestingPage extends StatelessWidget {
  const Level6TestingPage({super.key});

  static const Color _blue = Color(0xFF0A60C2);
  static const Color _darkBlue = Color(0xFF0A0A30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header (unchanged)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF8B5CF6),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Level 6',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Soft and Bite-Sized',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Testing title (now very dark blue)
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: _blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Testing',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: _darkBlue,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Two images side by side, larger and using BoxFit.contain
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Piece break thumbnail (enlarged + contain)
                            Container(
                              width: 200,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _darkBlue,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  'assets/piece_break_thumbnail.jpg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            const SizedBox(width: 20),

                            // Fork pressure thumbnail (enlarged + contain)
                            Container(
                              width: 200,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _darkBlue,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  'assets/fork_pressure_thumb6.webp',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Fork Pressure Test heading (plain, dark blue)
                      const Text(
                        'Fork Pressure Test',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _darkBlue,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // STEP 1 (wrapped in dotted border)
                      DottedBorder(
                        color: _darkBlue,
                        strokeWidth: 1.5,
                        dashPattern: const [4, 2],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: _buildStep(
                            number: '1',
                            description:
                                'Pressure from a fork held on its side can be used to cut or break apart or flake this texture into smaller pieces.',
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // STEP 2 (wrapped in dotted border)
                      DottedBorder(
                        color: _darkBlue,
                        strokeWidth: 1.5,
                        dashPattern: const [4, 2],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: _buildStep(
                            number: '2',
                            description:
                                'When a sample the size of a thumbnail (1.5 × 1.5 cm) is pressed with the tines of a fork to a pressure where the thumbnail blanches to white, the sample squashes, breaks apart, changes shape, and does not return to its original shape when the fork is removed.',
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Spoon Pressure Test heading (plain, dark blue)
                      const Text(
                        'Spoon Pressure Test',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _darkBlue,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // STEP 1
                      DottedBorder(
                        color: _darkBlue,
                        strokeWidth: 1.5,
                        dashPattern: const [4, 2],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: _buildStep(
                            number: '1',
                            description:
                                'Pressure from a spoon held on its side can be used to cut or break this texture into smaller pieces.',
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // STEP 2
                      DottedBorder(
                        color: _darkBlue,
                        strokeWidth: 1.5,
                        dashPattern: const [4, 2],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: _buildStep(
                            number: '2',
                            description:
                                'When a sample the size of a thumbnail (1.5 × 1.5 cm) is pressed with the base of a spoon, the sample squashes, breaks apart, changes shape, and does not return to its original shape when the spoon is removed.',
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Chopstick Test heading (plain, dark blue)
                      const Text(
                        'Chopstick Test',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _darkBlue,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // STEP 1
                      DottedBorder(
                        color: _darkBlue,
                        strokeWidth: 1.5,
                        dashPattern: const [4, 2],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: _buildStep(
                            number: '1',
                            description:
                                'Chopsticks can be used to break this texture into smaller pieces or puncture food.',
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildStep({
    required String number,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 0), // shifted inside DottedBorder
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Numbered circle (white background, dark blue number)
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: _darkBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Description text (now very dark blue)
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: _darkBlue,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
