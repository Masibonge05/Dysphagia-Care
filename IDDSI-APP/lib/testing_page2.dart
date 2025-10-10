import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'screens/fullscreen_image_page.dart';

class LevelOptionsPage extends StatelessWidget {
  final int levelNumber;
  final String levelType;
  final String pageTitle; // To display the level title

  const LevelOptionsPage({
    super.key,
    required this.levelNumber,
    required this.levelType,
    required this.pageTitle,
  });

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Custom Header (similar to LevelDetailPage)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: _getLevelColor(levelNumber,
                        levelType), // Function to get color based on level
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pageTitle, // Display the specific page title
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _getTextColor(levelNumber,
                              levelType), // Adjust text color based on background
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded,
                            color: _getTextColor(
                                levelNumber, levelType)), // Adjust icon color
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Options will be added here
                        _buildOptionButton(context, 'Testing', () {
                          if (levelNumber == 0 && levelType == 'Fluid') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FullScreenImagePage(
                                  imagePath:
                                      'assets/images/level_0_testing.png',
                                ),
                              ),
                            );
                          } else {
                            Navigator.pushNamed(
                              context,
                              '/level${levelNumber}_${levelType.toLowerCase()}_testing', // This route now maps to LevelDetailPage with showTesting: true
                              arguments: {
                                'levelNumber': levelNumber,
                                'levelType': levelType,
                                'pageTitle': pageTitle,
                                'showTesting': true,
                                'showTestingMethods':
                                    false, // Ensure testing methods are not shown
                              },
                            );
                          }
                        }),
                        const SizedBox(height: 10),
                        _buildOptionButton(context, 'Testing Methods', () {
                          // Navigate to LevelDetailPage to show formatted testing methods
                          Navigator.pushNamed(
                            context,
                            '/level${levelNumber}_${levelType.toLowerCase()}_testingmethods', // New route for testing methods view
                            arguments: {
                              'levelNumber': levelNumber,
                              'levelType': levelType,
                              'pageTitle': pageTitle,
                              'showTesting':
                                  false, // Ensure testing image/steps are not shown
                              'showTestingMethods':
                                  true, // Show testing methods
                            },
                          );
                        }),
                        // Add other options as needed
                        if ((levelNumber == 3 || levelNumber == 4) &&
                            levelType == 'Food') // Add Level 4 check
                          const SizedBox(height: 10),
                        if ((levelNumber == 3 || levelNumber == 4) &&
                            levelType == 'Food') // Add Level 4 check
                          _buildOptionButton(context, 'Food Specific', () {
                            // Navigate to Food Specific information page
                            Navigator.pushNamed(
                              context,
                              '/level${levelNumber}_${levelType.toLowerCase()}_foodspecific', // New route for Food Specific view
                              arguments: {
                                'levelNumber': levelNumber,
                                'levelType': levelType,
                                'pageTitle': pageTitle,
                                'showTesting':
                                    false, // Ensure testing image/steps are not shown
                                'showTestingMethods':
                                    false, // Ensure testing methods are not shown
                                'showFoodSpecific':
                                    true, // Show Food Specific content
                              },
                            );
                          }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF368DF3),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/home.svg', height: 24),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/list.svg', height: 24),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/testing.svg', height: 24),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/chatbot.svg', height: 24),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/person.svg', height: 24),
              label: ''),
        ],
        currentIndex: 1, // You might adjust this based on which page is active
        onTap: (index) {},
      ),
    );
  }

  Color _getLevelColor(int levelNumber, String levelType) {
    if (levelType == 'Fluid') {
      switch (levelNumber) {
        case 0:
          return const Color(0xFFA6E3D0);
        case 1:
          return const Color(0xFF616566);
        case 2:
          return const Color(0xFFEE60A2);
        case 3:
          return const Color(0xFFE8D900);
        case 4:
          return const Color(0xFF76C04F);
        default:
          return Colors.blue;
      }
    } else if (levelType == 'Food') {
      switch (levelNumber) {
        case 3:
          return const Color(0xFFE8D900);
        case 4:
          return const Color(0xFF76C04F);
        case 5:
          return const Color(0xFFF0763D);
        case 6:
          return const Color(0xFF0175BC);
        case 7:
          return const Color(0xFF2E2E31);
        default:
          return Colors.orange;
      }
    }
    return Colors.grey;
  }

  Color _getTextColor(int levelNumber, String levelType) {
    if (levelNumber == 0 && levelType == 'Fluid') {
      return Colors.black87;
    } else {
      return Colors.white;
    }
  }

  Widget _buildOptionButton(
      BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Take full width
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white
              .withOpacity(0.8), // White background with some transparency
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
