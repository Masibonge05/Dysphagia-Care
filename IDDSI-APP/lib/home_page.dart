import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'notifications.dart';
import 'level_data.dart'; // Import the new level data file

// Imported Pages
import 'mood_emoji.dart';
import 'package:iddsi_app/what_is_iddsi_page.dart';
import 'package:iddsi_app/what_is_dysphagia_page.dart';
import 'package:iddsi_app/disclaimer_page.dart';
import 'package:iddsi_app/signs_symptoms_page.dart';
import 'package:iddsi_app/dysphagia_info_page.dart'; // NEW
import 'package:iddsi_app/tips_adults_page.dart'; // NEW
import 'package:iddsi_app/user_profile_page.dart'; // NEW
import 'package:iddsi_app/app_drawer.dart'; // NEW - Separate drawer component

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
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // NEW - For drawer

  // Firebase user data
  String _userName = 'User';
  String? _currentUserId;
  String? _userProfileImage; // NEW - for profile picture
  int _unreadNotificationCount = 0;
  String? _selectedLevel; // Store the selected level value
  LevelData? _currentLevelData; // Store the level data
  List<FoodSuggestion> _foodSuggestions = []; // Store food suggestions

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
          _selectedLevel = userData['selectedLevel'];
          _userProfileImage =
              userData['profileImage']; // NEW - Load profile image

          // Load level data
          if (_selectedLevel != null) {
            _currentLevelData = LevelDataProvider.getLevelData(_selectedLevel!);
            _foodSuggestions = _currentLevelData?.foodSuggestions ?? [];
          }
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

  void _navigateToProfile() async {
    // NEW - Navigate to profile page with refresh
    if (_currentUserId != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfilePage(
            userId: _currentUserId!,
            userName: _userName,
            userProfileImage: _userProfileImage,
          ),
        ),
      );
      if (result == true) {
        await _fetchUserData(_currentUserId!);
      }
    } else {
      Navigator.pushNamed(context, '/profile');
    }
  }

  void _navigateToSearch() {
    Navigator.pushNamed(context, '/search');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFE8E8E8),
      drawer: AppDrawer(
        userName: _userName,
        userProfileImage: _userProfileImage,
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
                          GestureDetector(
                            onTap: _navigateToProfile,
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.white,
                              backgroundImage: _userProfileImage != null
                                  ? NetworkImage(_userProfileImage!)
                                  : null,
                              child: _userProfileImage == null
                                  ? const Icon(
                                      Icons.person,
                                      color: Color(0xFF44157F),
                                      size: 30,
                                    )
                                  : null,
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
                              _scaffoldKey.currentState?.openDrawer();
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
                      // Search bar
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
                      const SizedBox(height: 25),

                      // Current Saved Level - Dynamic
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
                                  decoration: BoxDecoration(
                                    color: _currentLevelData?.color ??
                                        const Color(0xFFFFD700),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: Text(
                                    _currentLevelData?.label ??
                                        'No Level Selected',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Food Suggestions - Dynamic
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
                              Expanded(
                                child: Text(
                                  _currentLevelData?.label ??
                                      'No Level Selected',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: _currentLevelData?.color ??
                                      const Color(0xFFFFD700),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Food items - Dynamic based on level
                      if (_foodSuggestions.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB0E0E6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 250,
                                child: Stack(
                                  children: [
                                    PageView.builder(
                                      controller: _foodPageController,
                                      onPageChanged: (index) {
                                        setState(() {
                                          currentFoodIndex = index;
                                        });
                                      },
                                      itemCount:
                                          (_foodSuggestions.length / 2).ceil(),
                                      itemBuilder: (context, pageIndex) {
                                        return Padding(
                                          padding: const EdgeInsets.all(30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
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
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      child: ClipOval(
                                                        child: Image.asset(
                                                          _foodSuggestions[
                                                                  pageIndex * 2]
                                                              .image,
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
                                                      _foodSuggestions[
                                                              pageIndex * 2]
                                                          .name,
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
                                              ),
                                              const SizedBox(width: 20),
                                              // Second food item
                                              if (pageIndex * 2 + 1 <
                                                  _foodSuggestions.length)
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        height: 120,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        child: ClipOval(
                                                          child: Image.asset(
                                                            _foodSuggestions[
                                                                    pageIndex *
                                                                            2 +
                                                                        1]
                                                                .image,
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
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .fastfood,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 40,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      Text(
                                                        _foodSuggestions[
                                                                pageIndex * 2 +
                                                                    1]
                                                            .name,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              else
                                                const Expanded(
                                                    child: SizedBox()),
                                            ],
                                          ),
                                        );
                                      },
                                    ),

                                    // Left arrow
                                    if (_foodSuggestions.length > 2)
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

                                    // Right arrow
                                    if (_foodSuggestions.length > 2)
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        bottom: 0,
                                        width: 80,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (currentFoodIndex <
                                                (_foodSuggestions.length > 1
                                                    ? (_foodSuggestions.length /
                                                                2)
                                                            .ceil() -
                                                        1
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
                                  _foodSuggestions.length > 1
                                      ? (_foodSuggestions.length / 2).ceil()
                                      : 1,
                                  (index) => Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
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
                        )
                      else
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB0E0E6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              'No food suggestions available.\nPlease select your level in settings.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF333333),
                              ),
                              textAlign: TextAlign.center,
                            ),
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
                          _buildLearnButton('What is\nDysphagia?', () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DysphagiaInfoPage()));
                          }),
                          _buildLearnButton(
                              'What are\nIDDSI Levels?', _navigateToFramework),
                          _buildLearnButton(
                              'How to\nTest Food', _navigateToFoodTesting),
                          _buildLearnButton('Tips for\nOlder Adults', () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TipsAdultsPage()));
                          }),
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
