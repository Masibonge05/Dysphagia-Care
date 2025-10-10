import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  String? _expandedKey;

  // Navigation methods
  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _navigateToFramework(BuildContext context) {
    Navigator.pushNamed(context, '/framework');
  }

  void _navigateToFoodTesting(BuildContext context) {
    print('Already on Testing Page');
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
                      'Testing Page',
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
                      _frameworkButton(context, 0, 'Thin', Colors.white, '/level0', _expandedKey == '/level0', () {
                        setState(() {
                          _expandedKey = _expandedKey == '/level0' ? null : '/level0';
                        });
                      }),
                      _frameworkButton(context, 1, 'Slightly Thick', const Color(0xFF616566), '/level1', _expandedKey == '/level1', () {
                        setState(() {
                          _expandedKey = _expandedKey == '/level1' ? null : '/level1';
                        });
                      }),
                      _frameworkButton(context, 2, 'Mildly Thick', const Color(0xFFEE60A2), '/level2', _expandedKey == '/level2', () {
                        setState(() {
                          _expandedKey = _expandedKey == '/level2' ? null : '/level2';
                        });
                      }),
                      _frameworkButton(context, 3, 'Moderately Thick', const Color(0xFFE8D900), '/level3', _expandedKey == '/level3', () {
                        setState(() {
                          _expandedKey = _expandedKey == '/level3' ? null : '/level3';
                        });
                      }),
                      _frameworkButton(context, 4, 'Extremely Thick', const Color(0xFF76C04F), '/level4', _expandedKey == '/level4', () {
                        setState(() {
                          _expandedKey = _expandedKey == '/level4' ? null : '/level4';
                        });
                      }),
                      const SizedBox(height: 20),
                      const Text('Food',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _frameworkButton(context, 3, 'Liquidised', const Color(0xFFE8D900), '/food3', _expandedKey == '/food3', () {
                        setState(() {
                          _expandedKey = _expandedKey == '/food3' ? null : '/food3';
                        });
                      }),
                      _frameworkButton(context, 4, 'Puréed', const Color(0xFF76C04F), '/food4', _expandedKey == '/food4', () {
                        setState(() {
                          _expandedKey = _expandedKey == '/food4' ? null : '/food4';
                        });
                      }),
                      _frameworkButton(context, 5, 'Minced and Moist', const Color(0xFFF0763D), '/food5', _expandedKey == '/food5', () {
                        setState(() {
                          _expandedKey = _expandedKey == '/food5' ? null : '/food5';
                        });
                      }),
                      _frameworkButton(context, 6, 'Soft and Bite-Sized', const Color(0xFF0175BC), '/food6', _expandedKey == '/food6', () {
                        setState(() {
                          _expandedKey = _expandedKey == '/food6' ? null : '/food6';
                        });
                      }),
                      _frameworkButton(context, 7, 'Regular', const Color(0xFF2E2E31), '/food7', _expandedKey == '/food7', () {
                        setState(() {
                          _expandedKey = _expandedKey == '/food7' ? null : '/food7';
                        });
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
                  isSelected: false,
                  label: 'Records',
                  onTap: () => _navigateToFramework(context),
                ),
                _buildNavItem(
                  context: context,
                  iconPath: 'assets/icons/testing.svg',
                  isSelected: true, // Testing is selected (this page)
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

static Widget _frameworkButton(BuildContext context, int number, String label, Color color, String route, bool isExpanded, VoidCallback onToggle) {
  String levelType = route.startsWith('/level') ? 'Fluid' : 'Food';

  void navigate(String selectedValue) {
    String targetRoute;
    Map<String, dynamic> arguments = {
      'levelNumber': number,
      'levelType': levelType,
      'pageTitle': 'Level $number: $label',
    };

    if (selectedValue == 'testing') {
      targetRoute = '/level${number}_${levelType.toLowerCase()}_testing';
      arguments['showTesting'] = true;
      arguments['showTestingMethods'] = false;
      arguments['showFoodSpecific'] = false;
    } else if (selectedValue == 'testingMethods') {
      targetRoute = '/level${number}_${levelType.toLowerCase()}_testingmethods';
      arguments['showTesting'] = false;
      arguments['showTestingMethods'] = true;
      arguments['showFoodSpecific'] = false;
    } else {
      targetRoute = '/level${number}_${levelType.toLowerCase()}_foodspecific';
      arguments['showTesting'] = false;
      arguments['showTestingMethods'] = false;
      arguments['showFoodSpecific'] = true;
    }

    Navigator.pushNamed(context, targetRoute, arguments: arguments);
  }

  return Align(
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, route),
          child: Container(
            constraints: const BoxConstraints(minHeight: 40),
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF548AD8), Color(0xFF8256D5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onToggle,
                  child: Transform.rotate(
                    angle: isExpanded ? 4.71239 : 1.5708,
                    child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            margin: const EdgeInsets.only(left: 12, bottom: 8),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => navigate('testing'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF01224F),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  ),
                  child: const Text(
                    'Testing',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () => navigate('testingMethods'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF01224F),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  ),
                  child: const Text(
                    'Testing Methods',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                if ((number >= 3 && number <= 7) && levelType == 'Food') ...[
                  const SizedBox(height: 4),
                  TextButton(
                    onPressed: () => navigate('foodSpecific'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF01224F),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    ),
                    child: const Text(
                      'Food Specific',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    ),
  );
}
}