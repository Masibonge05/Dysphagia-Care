import 'package:flutter/material.dart';
import 'package:iddsi_app/terms_conditions_page.dart';
import 'package:iddsi_app/about_app_page.dart';
import 'package:iddsi_app/about_speech_therapists_page.dart';
import 'package:iddsi_app/report_problem_page.dart';
import 'package:iddsi_app/faq_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  final String userName;
  final String? userProfileImage;

  const AppDrawer({
    super.key,
    required this.userName,
    this.userProfileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF44157F),
              Color(0xFF7A60D6),
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Custom Drawer Header with Profile
            Container(
              padding: const EdgeInsets.only(
                  top: 40, left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF44157F).withOpacity(0.9),
                    const Color(0xFF7A60D6).withOpacity(0.9),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Picture
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: userProfileImage != null &&
                              userProfileImage!.isNotEmpty
                          ? Image.network(
                              userProfileImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.white,
                                  child: const Icon(
                                    Icons.person,
                                    color: Color(0xFF44157F),
                                    size: 40,
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: Colors.white,
                              child: const Icon(
                                Icons.person,
                                color: Color(0xFF44157F),
                                size: 40,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // User Name - FIXED overflow
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Dysphagia Care User',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Menu Items
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // App Information Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.apps,
                            color: Color(0xFF44157F), size: 20),
                        const SizedBox(width: 10),
                        Text(
                          'App Information',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  _buildMenuItem(
                    context,
                    icon: Icons.article_outlined,
                    title: 'Terms & Conditions',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsConditionsPage()),
                      );
                    },
                  ),

                  _buildMenuItem(
                    context,
                    icon: Icons.info_outlined,
                    title: 'About the App',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutAppPage()),
                      );
                    },
                  ),

                  _buildMenuItem(
                    context,
                    icon: Icons.medical_services_outlined,
                    title: 'About Speech Therapists',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AboutSpeechTherapistsPage()),
                      );
                    },
                  ),

                  const Divider(height: 1),

                  // Support Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.support_agent,
                            color: Color(0xFF44157F), size: 20),
                        const SizedBox(width: 10),
                        Text(
                          'Support',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  _buildMenuItem(
                    context,
                    icon: Icons.help_outline,
                    title: 'FAQ',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FAQPage()),
                      );
                    },
                  ),

                  _buildMenuItem(
                    context,
                    icon: Icons.bug_report_outlined,
                    title: 'Report a Problem',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReportProblemPage()),
                      );
                    },
                  ),

                  const Divider(height: 1),
                  const SizedBox(height: 10),

                  // Logout Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _handleLogout(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, size: 20),
                          SizedBox(width: 10),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // App Version
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF44157F),
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF333333),
        ),
      ),
      onTap: onTap,
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
        size: 20,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true && context.mounted) {
      try {
        await FirebaseAuth.instance.signOut();
        if (context.mounted) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error logging out: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
