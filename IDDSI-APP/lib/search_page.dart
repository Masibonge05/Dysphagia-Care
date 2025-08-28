import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _userName = 'User';
  String? _currentUserId;

  Map<String, List<String>> _foodIddsiData = {};
  Map<String, Map<String, dynamic>> _foodDetails = {};
  bool _isLoading = true;
  int _unreadNotificationCount = 0;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _fetchFoodsFromFirebase();
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
          _userName = userData['name'] ?? 'User';
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
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

  Future<void> _fetchFoodsFromFirebase() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('foods').get();

      Map<String, List<String>> foodData = {};
      Map<String, Map<String, dynamic>> foodDetailsData = {};

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String foodName = data['name'] ?? '';
        String iddsiLevel = data['iddsi_level'] ?? '';

        if (foodName.isNotEmpty && iddsiLevel.isNotEmpty) {
          foodData[foodName] = [iddsiLevel];

          List<dynamic> comments = data['comments'] ?? [];

          // Store additional food details
          foodDetailsData[foodName] = {
            'docId': doc.id,
            'average_rating': (data['average_rating'] ?? 0.0).toDouble(),
            'total_ratings': comments.length,
            'description': data['description'] ?? '',
            'comments': comments,
            'updated_at': data['updated_at'] ?? '',
          };
        }
      }

      setState(() {
        _foodIddsiData = foodData;
        _foodDetails = foodDetailsData;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching foods: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> _getRecentComments(String foodName) {
    Map<String, dynamic>? foodDetail = _foodDetails[foodName];
    if (foodDetail == null) return [];

    List<dynamic> comments = foodDetail['comments'] ?? [];

    // Convert to proper format and get latest 5 comments
    List<Map<String, dynamic>> formattedComments =
        comments.map((comment) => Map<String, dynamic>.from(comment)).toList();

    // Sort by timestamp (most recent first) and take first 5
    formattedComments.sort((a, b) {
      String timestampA = a['timestamp'] ?? '';
      String timestampB = b['timestamp'] ?? '';
      return timestampB.compareTo(timestampA);
    });

    return formattedComments.take(5).toList();
  }

  Future<void> _submitRatingAndComment(
      String foodName, int rating, String comment) async {
    if (_currentUserId == null) return;

    try {
      String foodDocId = _foodDetails[foodName]?['docId'] ?? '';
      if (foodDocId.isEmpty) return;

      DocumentReference foodRef =
          FirebaseFirestore.instance.collection('foods').doc(foodDocId);

      // Get current food data
      DocumentSnapshot foodDoc = await foodRef.get();
      Map<String, dynamic> foodData = foodDoc.data() as Map<String, dynamic>;

      List<dynamic> currentComments = foodData['comments'] ?? [];
      double currentAvgRating = (foodData['average_rating'] ?? 0.0).toDouble();

      // Create new comment object
      Map<String, dynamic> newComment = {
        'userId': _currentUserId,
        'userName': _userName,
        'comment': comment,
        'rating': rating,
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Add new comment to the array
      currentComments.add(newComment);

      // Calculate new average rating
      double totalRating = 0;
      int validRatings = 0;

      for (var commentItem in currentComments) {
        int commentRating = commentItem['rating'] ?? 0;
        if (commentRating > 0) {
          totalRating += commentRating;
          validRatings++;
        }
      }

      double newAvgRating = validRatings > 0 ? totalRating / validRatings : 0.0;

      // Update the document
      await foodRef.update({
        'comments': currentComments,
        'average_rating': newAvgRating,
        'updated_at': DateTime.now().toIso8601String(),
      });

      // Update local data
      setState(() {
        _foodDetails[foodName]?['average_rating'] = newAvgRating;
        _foodDetails[foodName]?['total_ratings'] = currentComments.length;
        _foodDetails[foodName]?['comments'] = currentComments;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rating and comment submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error submitting rating: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit rating. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showRatingDialog(String foodName) {
    int selectedRating = 5;
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Rate $foodName',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF374151),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'How was your experience with this food?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setDialogState(() {
                            selectedRating = index + 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            Icons.star,
                            size: 36,
                            color: index < selectedRating
                                ? Colors.amber
                                : Colors.grey[300],
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$selectedRating star${selectedRating != 1 ? 's' : ''}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF374151),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Share your experience... (optional)',
                      hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF6366F1)),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Color(0xFF6B7280)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _submitRatingAndComment(foodName, selectedRating,
                        commentController.text.trim());
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildStarRating(double rating, int totalRatings) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            if (index < rating.floor()) {
              return const Icon(Icons.star, size: 16, color: Colors.amber);
            } else if (index < rating) {
              return const Icon(Icons.star_half, size: 16, color: Colors.amber);
            } else {
              return const Icon(Icons.star_border,
                  size: 16, color: Colors.amber);
            }
          }),
        ),
        const SizedBox(width: 8),
        Text(
          rating > 0
              ? '${rating.toStringAsFixed(1)} ($totalRatings review${totalRatings != 1 ? 's' : ''})'
              : 'No reviews yet',
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  void _navigateToNotifications() {
    print('Navigate to notifications');
  }

  List<String> _getFrequentlySearchedFoods() {
    List<String> allFoods = _foodIddsiData.keys.toList();
    return allFoods.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredFoods = _foodIddsiData.keys
        .where((food) => food.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    List<String> frequentlySearchedFoods = _getFrequentlySearchedFoods();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Section with Gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF6366F1),
                      Color(0xFF8B5CF6),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Bar with Profile and Icons
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: Color(0xFF6366F1),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
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
                                const Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                if (_unreadNotificationCount > 0)
                                  Positioned(
                                    right: 0,
                                    top: 0,
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
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) => setState(() => _query = value),
                          decoration: const InputDecoration(
                            hintText: 'Search for a food item...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xFF6366F1),
                              size: 24,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              // Content Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Suggestions Title
                      const Text(
                        'Frequently Searched:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Food Suggestion Chips
                      _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF6366F1),
                              ),
                            )
                          : Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: frequentlySearchedFoods.map((food) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _query = food;
                                      _searchController.text = food;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF93C5FD),
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      food,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                      const SizedBox(height: 30),

                      // Search Results
                      if (_query.isNotEmpty && !_isLoading)
                        Expanded(
                          child: filteredFoods.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No results found.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: filteredFoods.length,
                                  itemBuilder: (context, index) {
                                    String food = filteredFoods[index];
                                    Map<String, dynamic>? foodDetail =
                                        _foodDetails[food];

                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            spreadRadius: 0,
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: ExpansionTile(
                                        tilePadding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 8,
                                        ),
                                        childrenPadding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 16,
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              food,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF374151),
                                              ),
                                            ),
                                            if (foodDetail != null) ...[
                                              const SizedBox(height: 4),
                                              _buildStarRating(
                                                foodDetail['average_rating'] ??
                                                    0.0,
                                                foodDetail['total_ratings'] ??
                                                    0,
                                              ),
                                            ],
                                          ],
                                        ),
                                        iconColor: const Color(0xFF6366F1),
                                        collapsedIconColor:
                                            const Color(0xFF6366F1),
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // IDDSI Level
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'IDDSI Level:',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFF374151),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 12,
                                                        vertical: 6,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                                0xFF93C5FD)
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Text(
                                                        _foodIddsiData[food]!
                                                            .first,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xFF6366F1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // Rate This Food Button
                                              const SizedBox(height: 16),
                                              Center(
                                                child: ElevatedButton.icon(
                                                  onPressed: () =>
                                                      _showRatingDialog(food),
                                                  icon: const Icon(Icons.star,
                                                      size: 18,
                                                      color: Colors.white),
                                                  label: const Text(
                                                    'Rate This Food',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF6366F1),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 24,
                                                      vertical: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // Comments Section
                                              const SizedBox(height: 20),
                                              const Text(
                                                'Recent Reviews:',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF374151),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Builder(
                                                builder: (context) {
                                                  List<Map<String, dynamic>>
                                                      recentComments =
                                                      _getRecentComments(food);

                                                  if (recentComments.isEmpty) {
                                                    return Container(
                                                      width: double.infinity,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFF9FAFB),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xFFE5E7EB),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'No reviews yet. Be the first to rate this food!',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xFF9CA3AF),
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    );
                                                  }

                                                  return Column(
                                                    children: recentComments
                                                        .map((comment) {
                                                      return Container(
                                                        margin: const EdgeInsets
                                                            .only(bottom: 8),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFFF9FAFB),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xFFE5E7EB),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  comment['userName'] ??
                                                                      'Anonymous',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xFF374151),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 8),
                                                                Row(
                                                                  children: List
                                                                      .generate(
                                                                          5,
                                                                          (index) {
                                                                    int rating =
                                                                        comment['rating'] ??
                                                                            0;
                                                                    return Icon(
                                                                      index < rating
                                                                          ? Icons
                                                                              .star
                                                                          : Icons
                                                                              .star_border,
                                                                      size: 12,
                                                                      color: Colors
                                                                          .amber,
                                                                    );
                                                                  }),
                                                                ),
                                                              ],
                                                            ),
                                                            if (comment['comment'] !=
                                                                    null &&
                                                                comment['comment']
                                                                    .toString()
                                                                    .isNotEmpty) ...[
                                                              const SizedBox(
                                                                  height: 6),
                                                              Text(
                                                                comment[
                                                                    'comment'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0xFF6B7280),
                                                                  height: 1.4,
                                                                ),
                                                              ),
                                                            ],
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
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
    );
  }
}
