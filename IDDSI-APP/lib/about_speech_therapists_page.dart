import 'package:flutter/material.dart';

class AboutSpeechTherapistsPage extends StatelessWidget {
  const AboutSpeechTherapistsPage({super.key});

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
          'About Speech Therapists',
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
            // Hero Header with Logo
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
                  // Department Logo
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/speech.logo.png',
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              'Speech Therapy\n& Audiology',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF44157F),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Speech Therapy & Audiology',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Department at Chris Hani Baragwanath Academic Hospital',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // About the Department
                  _buildSection(
                    title: 'About the Department',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'The Speech Therapy and Audiology Department at Chris Hani Baragwanath Academic Hospital (Bara) is a leading center for communication and swallowing disorders in South Africa.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color(0xFF44157F).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF44157F).withOpacity(0.3),
                            ),
                          ),
                          child: const Text(
                            'Bara is one of the largest hospitals in the world and serves the greater Soweto community.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF44157F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // What is a Speech-Language Pathologist
                  _buildSection(
                    title: 'What is a Speech-Language Pathologist?',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'A Speech-Language Pathologist (SLP), also known as a Speech Therapist, is a healthcare professional who specializes in the assessment, diagnosis, and treatment of:',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildBulletPoint(
                            'Communication disorders (speech, language, voice)'),
                        _buildBulletPoint('Swallowing disorders (dysphagia)'),
                        _buildBulletPoint('Cognitive-communication disorders'),
                        _buildBulletPoint('Feeding difficulties'),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color(0xFF44157F).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF44157F).withOpacity(0.3),
                            ),
                          ),
                          child: const Text(
                            'SLPs in South Africa complete a 4-year Bachelor\'s degree and are registered with the Health Professions Council of South Africa (HPCSA).',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Dysphagia Expertise
                  _buildSection(
                    title: 'Dysphagia Expertise at Bara',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Our speech therapists at Bara are specially trained in dysphagia management and use evidence-based practices to:',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildServiceItem(
                          'Assess Swallowing',
                          'Comprehensive clinical and instrumental assessments (FEES, VFSS)',
                        ),
                        _buildServiceItem(
                          'Diagnose Dysphagia',
                          'Identify the type, severity, and cause of swallowing difficulties',
                        ),
                        _buildServiceItem(
                          'Prescribe IDDSI Levels',
                          'Determine the safest food and drink textures for each patient',
                        ),
                        _buildServiceItem(
                          'Provide Therapy',
                          'Exercises and strategies to improve swallowing function',
                        ),
                        _buildServiceItem(
                          'Educate Patients',
                          'Teach safe swallowing techniques and dietary modifications',
                        ),
                        _buildServiceItem(
                          'Monitor Progress',
                          'Regular follow-ups to adjust treatment plans as needed',
                        ),
                      ],
                    ),
                  ),

                  // Why This App Was Created
                  _buildSection(
                    title: 'Why This App Was Created',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'This app was specifically designed for the speech therapists at Chris Hani Baragwanath Hospital to:',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildPurposeItem(
                          'Standardize Care',
                          'Ensure consistent application of IDDSI guidelines',
                        ),
                        _buildPurposeItem(
                          'Improve Communication',
                          'Bridge the gap between therapists, patients, and caregivers',
                        ),
                        _buildPurposeItem(
                          'Enhance Education',
                          'Provide multilingual resources in South African languages',
                        ),
                        _buildPurposeItem(
                          'Increase Safety',
                          'Reduce aspiration risk through proper food selection',
                        ),
                        _buildPurposeItem(
                          'Empower Patients',
                          'Give patients tools to manage dysphagia independently',
                        ),
                      ],
                    ),
                  ),

                  // When to See a Speech Therapist
                  _buildSection(
                    title: 'When to See a Speech Therapist',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'See a speech therapist if you or a loved one experiences:',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildWarningItem(
                            'Coughing or choking when eating or drinking'),
                        _buildWarningItem(
                            'Feeling like food is stuck in the throat'),
                        _buildWarningItem(
                            'Wet or gurgly voice after swallowing'),
                        _buildWarningItem('Pain when swallowing'),
                        _buildWarningItem('Unexplained weight loss'),
                        _buildWarningItem(
                            'Recurrent chest infections or pneumonia'),
                        _buildWarningItem('Avoiding certain foods or drinks'),
                        _buildWarningItem('Taking a long time to eat meals'),
                      ],
                    ),
                  ),

                  // How to Access Services at Bara
                  _buildSection(
                    title: 'How to Access Services',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Speech therapy services at Chris Hani Baragwanath Hospital:',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildAccessItem(
                          'Referral Required',
                          'You need a referral from a doctor (GP or specialist) to see a speech therapist at Bara.',
                        ),
                        _buildAccessItem(
                          'Public Sector',
                          'Services are available through the public healthcare system. Patients with medical aid can also access services.',
                        ),
                        _buildAccessItem(
                          'Outpatient & Inpatient',
                          'Speech therapy is available for both outpatients and admitted patients.',
                        ),
                        _buildAccessItem(
                          'Multidisciplinary Team',
                          'Speech therapists work closely with doctors, dietitians, nurses, and occupational therapists.',
                        ),
                      ],
                    ),
                  ),

                  // Important Notice
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF44157F).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF44157F),
                        width: 2,
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'IMPORTANT NOTICE',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44157F),
                            letterSpacing: 1.1,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'All dysphagia diagnoses and IDDSI level prescriptions MUST be made by a qualified Speech-Language Pathologist. This app is a support tool and does NOT replace professional assessment.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Contact Information
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
                          'Contact the Department',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44157F),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'For appointments or inquiries, please contact the Speech Therapy & Audiology Department at Chris Hani Baragwanath Academic Hospital.',
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

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF44157F),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
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
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF44157F),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurposeItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF44157F).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF44157F).withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
              color: Color(0xFF44157F),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF44157F),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningItem(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF44157F).withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF44157F).withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: Color(0xFF44157F),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
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
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF44157F),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}
