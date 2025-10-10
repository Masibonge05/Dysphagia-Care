import 'package:flutter/material.dart';
//import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'notifications.dart';
//user
// Imported Pages
import 'mood_emoji.dart';
import 'package:iddsi_app/what_is_iddsi_page.dart';
import 'package:iddsi_app/what_is_dysphagia_page.dart';
import 'package:iddsi_app/disclaimer_page.dart';
import 'package:iddsi_app/signs_symptoms_page.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final int currentLevel;

  const HomePage({
    super.key,
    required this.userName,
    required this.currentLevel,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int selectedMoodIndex = -1;
  late List<AnimationController> _animationControllers;
  int currentFoodIndex = 0;
  final PageController _foodPageController = PageController();

  // Firebase user data
  String _userName = 'User';
  String? _currentUserId;
  int _unreadNotificationCount = 0;

  final List<Map<String, dynamic>> foodItems = [
    {
      'image': 'assets/food/smooth_maize_porride.png',
      'name': 'Smooth Maize Porridge',
    },
    {
      'image': 'assets/food/liquidised_shicken_soup.png',
      'name': 'Liquidised Chicken Soup',
    },
    {
      'image': 'assets/food/custard.png',
      'name': 'Smooth Custard',
    },
    {
      'image': 'assets/food/mageu.png',
      'name': 'Traditional Mageu',
    },
    {
      'image': 'assets/food/pureed_vegetable_curry.png',
      'name': 'Pureed Vegetable Curry',
    },
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _animationControllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );
   
  }

  Future<void> _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUserId = user.uid;
      });
      await _fetchUserData(user.uid);
      await _fetchNotificationCount(user.uid);
    }
  }

  Future<void> _fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _userName = userData['name'] ?? widget.userName;
        });
      } else {
        setState(() {
          _userName = widget.userName;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        _userName = widget.userName;
      });
    }
  }

  Future<void> _fetchNotificationCount(String userId) async {
    try {
      QuerySnapshot notificationSnapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .where('userId', isEqualTo: userId)
          .where('read', isEqualTo: false)
          .get();

      setState(() {
        _unreadNotificationCount = notificationSnapshot.docs.length;
      });
    } catch (e) {
      print('Error fetching notification count: $e');
    }
  }

  void _navigateToNotifications() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const NotificationsPage()),
  );
}

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    _foodPageController.dispose();
    super.dispose();
  }

  // Navigation methods
  void _navigateToHome() {
    print('Already on Home Page');
  }

  void _navigateToFramework() {
    Navigator.pushNamed(context, '/framework');
  }

  void _navigateToFoodTesting() {
    Navigator.pushNamed(context, '/testing');
  }

  void _navigateToChatbot() {
    Navigator.pushNamed(context, '/chatbot');
  }

  void _navigateToProfile() {
    Navigator.pushNamed(context, '/profile');
  }

  void _navigateToSearch() {
    Navigator.pushNamed(context, '/search');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF44157F), // Use a color similar to your theme
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/iddsi-logo.png', // Your IDDSI logo path
                    height: 60,
                  ),
                  // You can add a SizedBox or Text below the logo if needed
                ],
              ),
            ),
            ListTile(
              leading: Image.asset('assets/icons/Vector (2).png',
                  width: 24, height: 24), // What is IDDSI icon
              title: const Text('What is the IDDSI?'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WhatIsIddsiPage()));
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/Vector (3).png',
                  width: 24, height: 24), // What is Dysphagia icon
              title: const Text('What is Dysphagia'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WhatIsDysphagiaPage()));
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/Vector (4).png',
                  width: 24, height: 24), // Disclaimer icon
              title: const Text('Disclaimer'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DisclaimerPage()));
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/Vector.png',
                  width: 24, height: 24), // Signs and Symptoms icon
              title: const Text('Signs and Symptoms'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignsSymptomsPage()));
              },
            ),
            // Add more ListTiles for other menu items as needed
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Top purple header with rounded bottom corners
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF44157F),
                    Color(0xFF7A60D6),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
                  child: Column(
                    children: [
                      // Header with profile and notifications
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: Color(0xFF44157F),
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi,',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                _userName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: _navigateToNotifications,
                            child: Stack(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.grey,
                                    size: 24,
                                  ),
                                ),
                                // Notification badge
                                if (_unreadNotificationCount > 0)
                                  Positioned(
                                    right: 2,
                                    top: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 16,
                                        minHeight: 16,
                                      ),
                                      child: Text(
                                        _unreadNotificationCount > 99
                                            ? '99+'
                                            : _unreadNotificationCount
                                                .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Scaffold.of(context)
                                  .openDrawer(); // Open the drawer
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.menu,
                                color: Colors.grey,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      // Search bar - Navigate to SearchPage when tapped
                      GestureDetector(
                        onTap: _navigateToSearch,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.search,
                                    color: Colors.grey, size: 22),
                              ),
                              Text(
                                'Search for...',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // How Do You Feel Today section
                      const Text(
                        'How Do You Feel Today?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const EmojiAnimationSelector(),
                      const SizedBox(height: 20),
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildMoodIcon(0),
                          _buildMoodIcon(1),
                          _buildMoodIcon(2),
                          _buildMoodIcon(3),
                          _buildMoodIcon(4),
                        ],
                      ),*/
                      const SizedBox(height: 25),

                      // Current Saved Level
                      const Text(
                        'Current Saved Level',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: _navigateToFramework,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 18),
                            child: Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFD700),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 18),
                                const Text(
                                  'Level 3: Moderately Thick',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Food Suggestions
                      const Text(
                        'Food Suggestions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Row(
                            children: [
                              const Text(
                                'Level 3: Moderately Thick',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFD700),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Food items - Show 2 at a time with smooth sliding
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFB0E0E6), // Powder blue background
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Stack(
                                children: [
                                  PageView.builder(
                                    controller: _foodPageController,
                                    onPageChanged: (index) {
                                      setState(() {
                                        currentFoodIndex = index;
                                      });
                                    },
                                    itemCount: foodItems.length > 1
                                        ? foodItems.length - 1
                                        : 1,
                                    itemBuilder: (context, pageIndex) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          children: [
                                            // First food item
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 120,
                                                    height: 120,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.transparent,
                                                    ),
                                                    child: ClipOval(
                                                      child: Image.asset(
                                                        foodItems[pageIndex]
                                                            ['image'],
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xFF44157F),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: const Icon(
                                                              Icons.fastfood,
                                                              color:
                                                                  Colors.white,
                                                              size: 40,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Text(
                                                    foodItems[pageIndex]
                                                        ['name'],
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xFF333333),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            // Second food item
                                            if (pageIndex + 1 <
                                                foodItems.length)
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: 120,
                                                      height: 120,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      child: ClipOval(
                                                        child: Image.asset(
                                                          foodItems[pageIndex +
                                                              1]['image'],
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color(
                                                                    0xFF44157F),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: const Icon(
                                                                Icons.fastfood,
                                                                color: Colors
                                                                    .white,
                                                                size: 40,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Text(
                                                      foodItems[pageIndex + 1]
                                                          ['name'],
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFF333333),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            else
                                              const Expanded(
                                                  child:
                                                      SizedBox()), // Empty space if no second item
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  // Left tap area for going to previous page
                                  if (currentFoodIndex > 0)
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      width: 80,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (currentFoodIndex > 0) {
                                            _foodPageController.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: const Center(
                                            child: Icon(
                                              Icons.chevron_left,
                                              color: Colors.grey,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  // Right tap area for going to next page
                                  if (currentFoodIndex <
                                      (foodItems.length > 1
                                          ? foodItems.length - 2
                                          : 0))
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      width: 80,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (currentFoodIndex <
                                              (foodItems.length > 1
                                                  ? foodItems.length - 2
                                                  : 0)) {
                                            _foodPageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: const Center(
                                            child: Icon(
                                              Icons.chevron_right,
                                              color: Colors.grey,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            // Page indicator dots
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                foodItems.length > 1 ? foodItems.length - 1 : 1,
                                (index) => Container(
                                  width: 8,
                                  height: 8,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentFoodIndex == index
                                        ? const Color(0xFF44157F)
                                        : Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Learn section
                      const Text(
                        'Learn',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Learn buttons grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1.5,
                        children: [
                          _buildLearnButton('What is\nDysphagia?', () {}),
                          _buildLearnButton(
                              'What are\nIDDSI Levels?', _navigateToFramework),
                          _buildLearnButton(
                              'How to\nTest Food', _navigateToFoodTesting),
                          _buildLearnButton('Tips for\nOlder Adults', () {}),
                        ],
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
                  iconPath: 'assets/icons/home.svg',
                  isSelected: true,
                  label: 'Home',
                  onTap: _navigateToHome,
                ),
                _buildNavItem(
                  iconPath: 'assets/icons/framework.svg',
                  isSelected: false,
                  label: 'Records',
                  onTap: _navigateToFramework,
                ),
                _buildNavItem(
                  iconPath: 'assets/icons/testing.svg',
                  isSelected: false,
                  label: 'Test',
                  onTap: _navigateToFoodTesting,
                ),
                _buildNavItem(
                  iconPath: 'assets/icons/profile.svg',
                  isSelected: false,
                  label: 'Chat',
                  onTap: _navigateToChatbot,
                ),
                _buildNavItem(
                  iconPath: 'assets/icons/Account.svg',
                  isSelected: false,
                  label: 'Profile',
                  onTap: _navigateToProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildLearnButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
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
