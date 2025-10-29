import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String? _currentUserId;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  String? _expandedNotificationId;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUserId = user.uid;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _markAsRead(String notificationId) async {
    if (_currentUserId == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(notificationId)
          .update({'read': true});
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }

  Future<void> _markAllAsRead() async {
    if (_currentUserId == null) return;

    try {
      QuerySnapshot unreadNotifications = await FirebaseFirestore.instance
          .collection('notifications')
          .where('userId', isEqualTo: _currentUserId)
          .where('read', isEqualTo: false)
          .get();

      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (var doc in unreadNotifications.docs) {
        batch.update(doc.reference, {'read': true});
      }
      await batch.commit();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All notifications marked as read'),
          backgroundColor: Color(0xFF44157F),
        ),
      );
    } catch (e) {
      print('Error marking all as read: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to mark all as read'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Color _getNotificationColor(String changeType) {
    // Professional muted colors for a clean look
    switch (changeType.toLowerCase()) {
      case 'added':
        return const Color(0xFF44157F); // Primary purple
      case 'deleted':
        return const Color(0xFF6B7280); // Muted gray
      case 'updated':
        return const Color(0xFF7A60D6); // Secondary purple
      default:
        return const Color(0xFF44157F); // Primary purple
    }
  }

  String _getChangeTypeText(String changeType) {
    switch (changeType.toLowerCase()) {
      case 'added':
        return 'Added';
      case 'deleted':
        return 'Removed';
      case 'updated':
        return 'Updated';
      default:
        return 'Update';
    }
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'Recently';

    try {
      DateTime dateTime = timestamp.toDate();
      DateTime now = DateTime.now();
      Duration difference = now.difference(dateTime);

      if (difference.inDays > 7) {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Recently';
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6B7280),
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[800],
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
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
        child: Column(
          children: [
            // Header with professional gradient
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
                      // Header row
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              'Notifications',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: _currentUserId != null
                                ? FirebaseFirestore.instance
                                    .collection('notifications')
                                    .where('userId', isEqualTo: _currentUserId)
                                    .where('read', isEqualTo: false)
                                    .snapshots()
                                : null,
                            builder: (context, snapshot) {
                              bool hasUnread = snapshot.hasData &&
                                  snapshot.data!.docs.isNotEmpty;

                              return GestureDetector(
                                onTap: hasUnread ? _markAllAsRead : null,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: hasUnread
                                        ? Colors.white.withOpacity(0.25)
                                        : Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    hasUnread ? 'Mark all read' : 'All read',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Notifications content
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF44157F),
                      ),
                    )
                  : _currentUserId == null
                      ? const Center(
                          child: Text(
                            'Please log in to view notifications',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('notifications')
                              .where('userId', isEqualTo: _currentUserId)
                              .orderBy('timestamp', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF44157F),
                                ),
                              );
                            }

                            if (snapshot.hasError) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Error loading notifications',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.notifications_none_outlined,
                                      size: 100,
                                      color: Colors.grey[300],
                                    ),
                                    const SizedBox(height: 24),
                                    const Text(
                                      'No notifications yet',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'You\'ll receive updates about food changes here',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            }

                            return RefreshIndicator(
                              color: const Color(0xFF44157F),
                              onRefresh: () async {
                                await Future.delayed(
                                    const Duration(milliseconds: 500));
                              },
                              child: ListView.builder(
                                controller: _scrollController,
                                padding: const EdgeInsets.all(20),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var doc = snapshot.data!.docs[index];
                                  var data = doc.data() as Map<String, dynamic>;

                                  String changeType =
                                      data['changeType'] ?? 'update';
                                  String foodName =
                                      data['foodName'] ?? 'Unknown Food';
                                  bool isRead = data['read'] ?? false;
                                  Timestamp? timestamp = data['timestamp'];
                                  String? iddsiLevel = data['iddsiLevel'];
                                  String? oldLevel = data['oldLevel'];
                                  String? category = data['category'];
                                  String? description = data['description'];
                                  String? preparation = data['preparation'];
                                  String? texture = data['texture'];

                                  // Generate formal message based on change type
                                  String message;
                                  switch (changeType.toLowerCase()) {
                                    case 'added':
                                      message = iddsiLevel != null
                                          ? '$foodName was added to Level $iddsiLevel'
                                          : '$foodName was added';
                                      break;
                                    case 'deleted':
                                      message = '$foodName was deleted';
                                      break;
                                    case 'updated':
                                      if (oldLevel != null &&
                                          iddsiLevel != null) {
                                        message =
                                            '$foodName\'s level was changed from Level $oldLevel to Level $iddsiLevel';
                                      } else {
                                        message = '$foodName was updated';
                                      }
                                      break;
                                    default:
                                      message = data['message'] ??
                                          data['body'] ??
                                          '$foodName was modified';
                                  }

                                  bool isExpanded =
                                      _expandedNotificationId == doc.id;
                                  bool hasDetails = (description != null &&
                                          description.isNotEmpty) ||
                                      (preparation != null &&
                                          preparation.isNotEmpty) ||
                                      (texture != null && texture.isNotEmpty);

                                  return Dismissible(
                                    key: Key(doc.id),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      _markAsRead(doc.id);
                                    },
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(right: 20),
                                      margin: const EdgeInsets.only(bottom: 16),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF44157F),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Mark as Read',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (!isRead) {
                                          _markAsRead(doc.id);
                                        }
                                        if (hasDetails) {
                                          setState(() {
                                            _expandedNotificationId =
                                                isExpanded ? null : doc.id;
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: isRead
                                              ? null
                                              : Border.all(
                                                  color: const Color(0xFF44157F)
                                                      .withOpacity(0.2),
                                                  width: 1.5,
                                                ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.04),
                                              spreadRadius: 0,
                                              blurRadius: 10,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Header row with badge and status
                                                  Row(
                                                    children: [
                                                      // Change type badge - professional and subtle
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 12,
                                                          vertical: 6,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              _getNotificationColor(
                                                                      changeType)
                                                                  .withOpacity(
                                                                      0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                        child: Text(
                                                          _getChangeTypeText(
                                                                  changeType)
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                _getNotificationColor(
                                                                    changeType),
                                                            letterSpacing: 0.5,
                                                          ),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      // Timestamp
                                                      Text(
                                                        _formatTimestamp(
                                                            timestamp),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.grey[500],
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      // Unread indicator
                                                      if (!isRead)
                                                        Container(
                                                          width: 8,
                                                          height: 8,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xFF44157F),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),

                                                  // Main message - clean and professional
                                                  Text(
                                                    message,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: isRead
                                                          ? FontWeight.w500
                                                          : FontWeight.w600,
                                                      color: const Color(
                                                          0xFF1F2937),
                                                      height: 1.5,
                                                      letterSpacing: 0.2,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),

                                                  // Category and Level badges - inline
                                                  Row(
                                                    children: [
                                                      if (category != null) ...[
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 10,
                                                            vertical: 5,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                    0xFF44157F)
                                                                .withOpacity(
                                                                    0.08),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          child: Text(
                                                            category
                                                                .toUpperCase(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color(
                                                                  0xFF44157F),
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                      ],
                                                      if (iddsiLevel !=
                                                          null) ...[
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 10,
                                                            vertical: 5,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                    0xFF7A60D6)
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          child: Text(
                                                            'LEVEL $iddsiLevel',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color(
                                                                  0xFF7A60D6),
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                      const Spacer(),
                                                      // Details hint
                                                      if (hasDetails)
                                                        Text(
                                                          isExpanded
                                                              ? 'Tap to collapse'
                                                              : 'Tap to view details',
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            color: Colors
                                                                .grey[500],
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Expandable details section - professional styling
                                            if (isExpanded && hasDetails)
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFF9FAFB),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(12),
                                                    bottomRight:
                                                        Radius.circular(12),
                                                  ),
                                                  border: Border(
                                                    top: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(0.15),
                                                    ),
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'FOOD DETAILS',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            Color(0xFF44157F),
                                                        letterSpacing: 1.0,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    if (description != null &&
                                                        description
                                                            .isNotEmpty) ...[
                                                      _buildDetailRow(
                                                          'Description',
                                                          description),
                                                      const SizedBox(
                                                          height: 12),
                                                    ],
                                                    if (texture != null &&
                                                        texture.isNotEmpty) ...[
                                                      _buildDetailRow(
                                                          'Texture', texture),
                                                      const SizedBox(
                                                          height: 12),
                                                    ],
                                                    if (preparation != null &&
                                                        preparation
                                                            .isNotEmpty) ...[
                                                      _buildDetailRow(
                                                          'Preparation',
                                                          preparation),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
