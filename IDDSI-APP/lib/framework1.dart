import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Imported Pages
import 'framework2.dart';

class FrameworkPage extends StatelessWidget {
  const FrameworkPage({super.key});

  // Navigation methods
  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/');
  }

  void _navigateToFramework(BuildContext context) {
    print('Already on Framework Page');
  }

  void _navigateToFoodTesting(BuildContext context) {
    Navigator.pushNamed(context, '/testing');
  }

  void _navigateToChatbot(BuildContext context) {
    Navigator.pushNamed(context, '/chatbot');
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Framework',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      const Text('Fluids',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _frameworkButton(
                          context, 0, 'Thin', Colors.white, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LevelDetailPage(
                              levelName: 'Thin',
                              levelNumber: '0',
                            ),
                          ),
                        );
                      }),
                      _frameworkButton(context, 1, 'Slightly Thick',
                          const Color(0xFF616566), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LevelDetailPage(
                              levelName: 'Slightly Thick',
                              levelNumber: '1',
                            ),
                          ),
                        );
                      }),
                      _frameworkButton(context, 2, 'Mildly Thick',
                          const Color(0xFFEE60A2), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LevelDetailPage(
                              levelName: 'Mildly Thick',
                              levelNumber: '2',
                            ),
                          ),
                        );
                      }),
                      _frameworkButton(context, 3, 'Moderately Thick',
                          const Color(0xFFE8D900), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LevelDetailPage(
                              levelName: 'Moderately Thick',
                              levelNumber: '3',
                            ),
                          ),
                        );
                      }),
                      _frameworkButton(context, 4, 'Extremely Thick',
                          const Color(0xFF76C04F), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LevelDetailPage(
                              levelName: 'Extremely Thick',
                              levelNumber: '4',
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      const Text('Food',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _frameworkButton(context, 3, 'Liquidised',
                          const Color(0xFFE8D900), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LevelDetailPage(
                              levelName: 'Liquidised',
                              levelNumber: '3',
                            ),
                          ),
                        );
                      }),
                      _frameworkButton(
                          context, 4, 'Puréed', const Color(0xFF76C04F), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LevelDetailPage(
                              levelName: 'Puréed',
                              levelNumber: '4',
                            ),
                          ),
                        );
                      }),
                      _frameworkButton(context, 5, 'Minced and Moist',
                          const Color(0xFFF0763D), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LevelDetailPage(
                              levelName: 'Minced and Moist',
                              levelNumber: '5',
                            ),
                          ),
                        );
                      }),
                      _frameworkButton(context, 6, 'Soft and Bite-Sized',
                          const Color(0xFF0175BC), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LevelDetailPage(
                              levelName: 'Soft and Bite-Sized',
                              levelNumber: '6',
                            ),
                          ),
                        );
                      }),
                      _frameworkButton(
                          context, 7, 'Regular', const Color(0xFF2E2E31), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LevelDetailPage(
                              levelName: 'Regular',
                              levelNumber: '7',
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 100), // Space for bottom nav
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context: context,
                  iconPath: 'assets/icons/home.svg',
                  isSelected: false,
                  label: 'Home',
                  onTap: () => _navigateToHome(context),
                ),
                _buildNavItem(
                  context: context,
                  iconPath: 'assets/icons/framework.svg',
                  isSelected: true, // This page is selected
                  label: 'Records',
                  onTap: () => _navigateToFramework(context),
                ),
                _buildNavItem(
                  context: context,
                  iconPath: 'assets/icons/testing.svg',
                  isSelected: false,
                  label: 'Test',
                  onTap: () => _navigateToFoodTesting(context),
                ),
                _buildNavItem(
                  context: context,
                  iconPath: 'assets/icons/profile.svg',
                  isSelected: false,
                  label: 'Chat',
                  onTap: () => _navigateToChatbot(context),
                ),
                _buildNavItem(
                  context: context,
                  iconPath: 'assets/icons/Account.svg',
                  isSelected: false,
                  label: 'Profile',
                  onTap: () => _navigateToProfile(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _frameworkButton(BuildContext context, int number, String label,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 382,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF548AD8), Color(0xFF8256D5)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 43,
              height: 43,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(33),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(22),
                ),
              ),
              child: Text(
                '$number',
                style: TextStyle(
                  color: (label == 'Thin' && number == 0)
                      ? const Color(0xFFA6E3D0)
                      : Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Level: $label',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required String iconPath,
    required bool isSelected,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF44157F).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            iconPath,
            color: isSelected ? const Color(0xFF44157F) : Colors.grey,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}