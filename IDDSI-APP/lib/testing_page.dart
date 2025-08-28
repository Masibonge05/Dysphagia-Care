import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

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
                          context, 0, 'Thin', Colors.white, '/level0'),
                      _frameworkButton(context, 1, 'Slightly Thick',
                          const Color(0xFF616566), '/level1'),
                      _frameworkButton(context, 2, 'Mildly Thick',
                          const Color(0xFFEE60A2), '/level2'),
                      _frameworkButton(context, 3, 'Moderately Thick',
                          const Color(0xFFE8D900), '/level3'),
                      _frameworkButton(context, 4, 'Extremely Thick',
                          const Color(0xFF76C04F), '/level4'),
                      const SizedBox(height: 20),
                      const Text('Food',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _frameworkButton(context, 3, 'Liquidised',
                          const Color(0xFFE8D900), '/food3'),
                      _frameworkButton(context, 4, 'Puréed',
                          const Color(0xFF76C04F), '/food4'),
                      _frameworkButton(context, 5, 'Minced and Moist',
                          const Color(0xFFF0763D), '/food5'),
                      _frameworkButton(context, 6, 'Soft and Bite-Sized',
                          const Color(0xFF0175BC), '/food6'),
                      _frameworkButton(context, 7, 'Regular',
                          const Color(0xFF2E2E31), '/food7'),
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

static Widget _frameworkButton(BuildContext context, int number, String label, Color color, String route) {
  return Align(
  alignment: Alignment.centerLeft, // or use .center if you prefer centered buttons
  child: GestureDetector(
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
            onTap: () async {
              final RenderBox button = context.findRenderObject() as RenderBox;
              final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
              final RelativeRect position = RelativeRect.fromRect(
                Rect.fromPoints(
                  button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
                  button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
                ),
                Offset.zero & overlay.size,
              );

              String levelType = route.startsWith('/level') ? 'Fluid' : 'Food';

              final List<PopupMenuEntry<String>> items = [
                const PopupMenuItem<String>(
                  value: 'testing',
                  child: Text('Testing'),
                ),
                const PopupMenuItem<String>(
                  value: 'testingMethods',
                  child: Text('Testing Methods'),
                ),
              ];

              // Add Food Specific option for levels 3 to 7 (Food)
              if ((number >= 3 && number <= 7) && levelType == 'Food') {
                items.add(
                  const PopupMenuItem<String>(
                    value: 'foodSpecific',
                    child: Text('Food Specific'),
                  ),
                );
              }

              final selectedValue = await showMenu<String>(
                context: context,
                position: position,
                items: items,
                elevation: 8.0,
              );

              // Navigate based on selected option
              if (selectedValue != null) {
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
                } else if (selectedValue == 'foodSpecific') {
                   targetRoute = '/level${number}_${levelType.toLowerCase()}_foodspecific';
                   arguments['showTesting'] = false;
                   arguments['showTestingMethods'] = false;
                   arguments['showFoodSpecific'] = true;
                } else {
                    return; // Should not happen
                }

                // Navigate to the determined route with arguments
                 Navigator.pushNamed(
                  context,
                  targetRoute,
                  arguments: arguments,
                );
              }
            },
            child: Transform.rotate(angle: 1.5708, child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16)),
          ),
        ],
      ),
    ),
  ),
);
}
}