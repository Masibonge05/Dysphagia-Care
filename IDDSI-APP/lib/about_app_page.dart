import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'About the App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF44157F),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Dysphagia Care',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Smart Multilingual Dysphagia Management Platform',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF44157F),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // What is Dysphagia Care App
                  _buildSection(
                    title: 'What is a Dysphagia Care App?',
                    content: const Text(
                      'A dysphagia care app is a digital health tool designed to assist speech therapists, patients, and caregivers in managing dysphagia — a medical condition that causes difficulty in swallowing. The app supports accurate assessment, food testing, and monitoring of patients\' dietary levels according to the IDDSI (International Dysphagia Diet Standardisation Initiative) framework.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),

                  // Our App
                  _buildSection(
                    title: 'Our App',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Our app is a smart, multilingual dysphagia management platform built specifically for Chris Hani Baragwanath Hospital to help speech therapists and patients apply the IDDSI framework effectively.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Key Features:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44157F),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildFeatureItem('Food Library',
                            'A digital database of tested foods categorized according to IDDSI levels.'),
                        _buildFeatureItem('Multilingual Chatbot',
                            'An AI chatbot that explains food levels, dysphagia care, and suitable meal options in all South African languages.'),
                        _buildFeatureItem('Food Testing & Rating',
                            'Therapists can upload test results, rate food textures, and attach supporting files or videos.'),
                        _buildFeatureItem('Notifications',
                            'In-app and email alerts for updates or new food entries.'),
                        _buildFeatureItem('Access Control',
                            'Only authorized speech therapists from Bara can edit and approve food entries.'),
                      ],
                    ),
                  ),

                  // Purpose and Impact
                  _buildSection(
                    title: 'Purpose and Impact',
                    content: const Text(
                      'The app improves communication, accuracy, and efficiency in dysphagia management by providing a standardized, accessible, and digital tool for healthcare professionals and patients. It also promotes safe swallowing practices and better quality of life for dysphagia patients.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),

                  // Development Team
                  _buildSection(
                    title: 'Development Team',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color(0xFF44157F).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF44157F).withOpacity(0.3),
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'University of Johannesburg',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF44157F),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '3rd Year BEng Electrical & Electronic Engineering',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'This app was developed by a dedicated team of 10 engineering students:',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildTeamMemberItem('Masibonge Shabalala'),
                        _buildTeamMemberItem('Michael Mpofu'),
                        _buildTeamMemberItem('Michelle Majebe'),
                        _buildTeamMemberItem('Njabulo Sibambo'),
                        _buildTeamMemberItem('Nzumbululo Nemakundani'),
                        _buildTeamMemberItem('Kgotso Shabalala'),
                        _buildTeamMemberItem('Mfanelo Myambo'),
                        _buildTeamMemberItem('Liyema Ndaliso'),
                        _buildTeamMemberItem('Tanaka Chichichi'),
                        _buildTeamMemberItem('Lesley Manaka'),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color(0xFF44157F).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Dedicated to improving dysphagia care in South Africa',
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF44157F),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Partner Institution
                  _buildSection(
                    title: 'Partner Institution',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Chris Hani Baragwanath Academic Hospital',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Speech Therapy & Audiology Department',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white70,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 15),
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'This app was designed specifically for the speech therapists and patients at Chris Hani Baragwanath Academic Hospital (Bara), one of the largest hospitals in the world and a leading center for speech therapy in South Africa.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Contact & Support
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF44157F).withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Need Help?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44157F),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'For support or inquiries, please contact the Speech Therapy Department at Chris Hani Baragwanath Academic Hospital.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0xFF333333),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Copyright Footer
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '© ${DateTime.now().year} Dysphagia Care',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'University of Johannesburg & Chris Hani Baragwanath Hospital',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF44157F).withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title with underline
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF44157F),
                  width: 2,
                ),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF44157F),
              ),
            ),
          ),
          const SizedBox(height: 20),
          content,
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF44157F).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF44157F).withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF44157F),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberItem(String name) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF44157F).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF44157F),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}
