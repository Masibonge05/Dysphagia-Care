import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  String? _expandedRouteKey;

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
                      _frameworkButton(
                        context,
                        number: 0,
                        label: 'Thin',
                        color: Colors.white,
                        route: '/level0',
                        isExpanded: _expandedRouteKey == '/level0',
                        onToggle: () {
                          setState(() {
                            _expandedRouteKey = _expandedRouteKey == '/level0' ? null : '/level0';
                          });
                        },
                      ),
                      _frameworkButton(
                        context,
                        number: 1,
                        label: 'Slightly Thick',
                        color: const Color(0xFF616566),
                        route: '/level1',
                        isExpanded: _expandedRouteKey == '/level1',
                        onToggle: () {
                          setState(() {
                            _expandedRouteKey = _expandedRouteKey == '/level1' ? null : '/level1';
                          });
                        },
                      ),
                      _frameworkButton(
                        context,
                        number: 2,
                        label: 'Mildly Thick',
                        color: const Color(0xFFEE60A2),
                        route: '/level2',
                        isExpanded: _expandedRouteKey == '/level2',
                        onToggle: () {
                          setState(() {
                            _expandedRouteKey = _expandedRouteKey == '/level2' ? null : '/level2';
                          });
                        },
                      ),
                      _frameworkButton(
                        context,
                        number: 3,
                        label: 'Moderately Thick',
                        color: const Color(0xFFE8D900),
                        route: '/level3',
                        isExpanded: _expandedRouteKey == '/level3',
                        onToggle: () {
                          setState(() {
                            _expandedRouteKey = _expandedRouteKey == '/level3' ? null : '/level3';
                          });
                        },
                      ),
                      _frameworkButton(
                        context,
                        number: 4,
                        label: 'Extremely Thick',
                        color: const Color(0xFF76C04F),
                        route: '/level4',
                        isExpanded: _expandedRouteKey == '/level4',
                        onToggle: () {
                          setState(() {
                            _expandedRouteKey = _expandedRouteKey == '/level4' ? null : '/level4';
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Food',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _frameworkButton(
                        context,
                        number: 3,
                        label: 'Liquidised',
                        color: const Color(0xFFE8D900),
                        route: '/food3',
                        isExpanded: _expandedRouteKey == '/food3',
                        onToggle: () {
                          setState(() {
                            _expandedRouteKey = _expandedRouteKey == '/food3' ? null : '/food3';
                          });
                        },
                      ),
                      _frameworkButton(
                        context,
                        number: 4,
                        label: 'Puréed',
                        color: const Color(0xFF76C04F),
                        route: '/food4',
                        isExpanded: _expandedRouteKey == '/food4',
                        onToggle: () {
                          setState(() {
                            _expandedRouteKey = _expandedRouteKey == '/food4' ? null : '/food4';
                          });
                        },
                      ),
                      _frameworkButton(
                        context,
                        number: 5,
                        label: 'Minced and Moist',
                        color: const Color(0xFFF0763D),
                        route: '/food5',
                        isExpanded: _expandedRouteKey == '/food5',
                        onToggle: () {
                          setState(() {
                            _expandedRouteKey = _expandedRouteKey == '/food5' ? null : '/food5';
                          });
                        },
                      ),
                      _frameworkButton(
                        context,
                        number: 6,
                        label: 'Soft and Bite-Sized',
                        color: const Color(0xFF0175BC),
                        route: '/food6',
                        isExpanded: _expandedRouteKey == '/food6',
                        onToggle: () {
                          setState(() {
                            _expandedRouteKey = _expandedRouteKey == '/food6' ? null : '/food6';
                          });
                        },
                      ),
                      _frameworkButton(
                        context,
                        number: 7,
                        label: 'Regular',
                        color: const Color(0xFF2E2E31),
                        route: '/food7',
                        isExpanded: _expandedRouteKey == '/food7',
                        onToggle: () {
                          setState(() {
                            _expandedRouteKey = _expandedRouteKey == '/food7' ? null : '/food7';
                          });
                        },
                      ),
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

static Widget _frameworkButton(
  BuildContext context, {
  required int number,
  required String label,
  required Color color,
  required String route,
  required bool isExpanded,
  required VoidCallback onToggle,
}) {
  String levelType = route.startsWith('/level') ? 'Fluid' : 'Food';

  return Align(
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggle,
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
                Transform.rotate(
                  angle: isExpanded ? 0 : 1.5708,
                  child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) ...[
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            margin: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _inlineOption(
                  context,
                  title: 'Testing',
                  onTap: () {
                    final Map<String, dynamic> arguments = {
                      'levelNumber': number,
                      'levelType': levelType,
                      'pageTitle': 'Level $number: $label',
                      'showTesting': true,
                      'showTestingMethods': false,
                      'showFoodSpecific': false,
                    };
                    final String targetRoute = '/level${number}_${levelType.toLowerCase()}_testing';
                    Navigator.pushNamed(context, targetRoute, arguments: arguments);
                  },
                ),
                const SizedBox(height: 8),
                _inlineOption(
                  context,
                  title: 'Testing Methods',
                  onTap: () {
                    final Map<String, dynamic> arguments = {
                      'levelNumber': number,
                      'levelType': levelType,
                      'pageTitle': 'Level $number: $label',
                      'showTesting': false,
                      'showTestingMethods': true,
                      'showFoodSpecific': false,
                    };
                    final String targetRoute = '/level${number}_${levelType.toLowerCase()}_testingmethods';
                    Navigator.pushNamed(context, targetRoute, arguments: arguments);
                  },
                ),
                if (levelType == 'Food' && number >= 3 && number <= 7) ...[
                  const SizedBox(height: 8),
                  _inlineOption(
                    context,
                    title: 'Food Specific',
                    onTap: () {
                      final Map<String, dynamic> arguments = {
                        'levelNumber': number,
                        'levelType': levelType,
                        'pageTitle': 'Level $number: $label',
                        'showTesting': false,
                        'showTestingMethods': false,
                        'showFoodSpecific': true,
                      };
                      final String targetRoute = '/level${number}_${levelType.toLowerCase()}_foodspecific';
                      Navigator.pushNamed(context, targetRoute, arguments: arguments);
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    ),
  );
}

static Widget _inlineOption(BuildContext context, {required String title, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFB3E5FC),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF01224F),
        ),
      ),
    ),
  );
}
}