// This page is displayed when a user taps on one of the IDDSI Levels
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Imported Pages
import 'level_detail_page.dart';
import 'recommended_food.dart';

class CustomGradientAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String titleText;
  final String levelText;
  final VoidCallback onBack;

  const CustomGradientAppBar({
    super.key,
    required this.titleText,
    required this.levelText,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4157FF), Color(0xFF7A60D6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Left Text
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Text(
                          titleText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      const SizedBox(width: 0),

                      // Center Text
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            levelText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      // Right SVG
                      GestureDetector(
                        onTap: onBack,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: SvgPicture.asset(
                            'assets/icons_sm/arrow2.svg',
                            width: 60, // Adjust size as needed
                            height: 60,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 0), // optional spacing from the bottom
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

// MAIN LEVEL PAGE
class LevelDetailPage extends StatelessWidget {
  final String levelName;
  final String levelNumber;

  const LevelDetailPage({
    super.key,
    required this.levelName,
    required this.levelNumber,
  });

  // Navigation methods
  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _navigateToFramework(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/framework', (route) => false);
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

  // Unique circle color per level
  Color getCircleColor(String levelNumber) {
    switch (levelNumber) {
      case '0':
        return Colors.white;
      case '1':
        return const Color(0xFF616566);
      case '2':
        return const Color(0xFFEE60A2);
      case '3':
        return const Color(0xFFE8D900);
      case '4':
        return const Color(0xFF76C04F);
      case '5':
        return const Color(0xFFF0763D);
      case '6':
        return const Color(0xFF0175BC);
      case '7':
        return const Color(0xFF2E2E31);
      case '9':
        return const Color(0xFF2E2E31);
      default:
        return const Color(0xFFF0763D);
    }
  }

  @override
  Widget build(BuildContext context) {
    final circleColor = getCircleColor(levelNumber);

    return Scaffold(
      appBar: CustomGradientAppBar(
        levelText: levelName,
        titleText: 'Level $levelNumber',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                // Tiles
                DetailTile(
                  title: 'Characteristics',
                  circleColor: circleColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacteristicsPage(
                          levelNumber: int.parse(levelNumber),
                          levelName: levelName,
                          levelColor: circleColor,
                        ),
                      ),
                    );
                  },
                ),
                DetailTile(
                  title: 'Physiological Rationale',
                  circleColor: circleColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhysiologicalRationalePage(
                          levelNumber: int.parse(levelNumber),
                          levelName: levelName,
                          levelColor: circleColor,
                        ),
                      ),
                    );
                  },
                ),
                DetailTile(
                  title: 'Recommended Food',
                  circleColor: circleColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecommendedFoodPage(
                          levelNumber: int.parse(levelNumber),
                          levelName: levelName,
                          levelColor: circleColor,
                        ),
                      ),
                    );
                  },
                ),
                DetailTile(
                  title: 'Testing Methods',
                  circleColor: circleColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestingMethodsPage(
                          //title: 'Testing Methods',
                          levelNumber: int.parse(levelNumber),
                          levelName: levelName,
                          levelColor: circleColor,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 100), // Space for bottom nav
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
                  isSelected: true, // Framework is selected (this page is part of framework)
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

// TILE THAT NAVIGATES
class DetailTile extends StatelessWidget {
  final String title;
  final Color circleColor;
  final VoidCallback onTap;

  const DetailTile({
    super.key,
    required this.title,
    required this.circleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: Color(0xFFF0F5F7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 2, 51, 121),
              offset: Offset(0, 20),
              blurRadius: 39,
              spreadRadius: -10,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 0.8),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xFF01224F)),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}