import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

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
          'Terms & Conditions',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF44157F),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                children: [
                  Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please read carefully before using the application',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Last Updated
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF44157F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF44157F).withOpacity(0.3),
                ),
              ),
              child: Text(
                'Last Updated: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF44157F),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Important Notice
            _buildImportantNotice(),
            const SizedBox(height: 25),

            // Medical Disclaimer
            _buildSection(
              'Medical Disclaimer',
              [
                'This app is NOT a medical device and is NOT intended to diagnose, treat, cure, or prevent any disease or medical condition.',
                'The Dysphagia Care App is designed as an educational and supportive tool only.',
                'All diagnoses MUST be made by qualified healthcare professionals, specifically Speech-Language Pathologists (Speech Therapists) or other licensed medical practitioners.',
                'The app does not replace professional medical advice, diagnosis, or treatment.',
              ],
            ),

            // Professional Consultation Required
            _buildSection(
              'Professional Consultation Required',
              [
                'Your dysphagia level and dietary recommendations MUST be determined by a qualified Speech-Language Pathologist (SLP) during a clinical assessment at a healthcare facility.',
                'The app relies on the IDDSI level prescribed by your speech therapist. You must enter the correct level as diagnosed by your healthcare provider.',
                'Never change your prescribed IDDSI level without consulting your speech therapist.',
                'If you experience any discomfort, difficulty swallowing, coughing, choking, or breathing difficulties while consuming any food or drink suggested by this app, STOP immediately and consult your speech therapist or seek emergency medical attention.',
              ],
            ),

            // Liability and Responsibility
            _buildSection(
              'Liability and Responsibility',
              [
                'The developers, University of Johannesburg, Chris Hani Baragwanath Academic Hospital, and all affiliated parties accept NO responsibility or liability for:',
                '• Choking incidents',
                '• Aspiration (food/liquid entering the airway)',
                '• Adverse reactions to food',
                '• Nutritional deficiencies',
                '• Any injury, harm, or death resulting from the use of this app',
                '• Errors in food suggestions or IDDSI classifications',
                '• Misuse or misinterpretation of app information',
                '',
                'By using this app, you acknowledge and accept all risks associated with dysphagia management and agree that you use this app entirely at your own risk.',
              ],
            ),

            // Food Suggestions
            _buildSection(
              'Food Suggestions & Safety',
              [
                'Food suggestions provided by this app are general recommendations based on IDDSI guidelines.',
                'Individual tolerance to foods varies greatly. What is safe for one person may not be safe for another.',
                'Always test new foods in small amounts and under supervision.',
                'Food texture, temperature, moisture content, and preparation methods significantly affect safety. Follow your speech therapist\'s specific instructions.',
                'The app cannot account for individual allergies, intolerances, or medical conditions. Always consider your personal health status.',
                'If unsure about any food item, consult your speech therapist before consuming.',
              ],
            ),

            // User Responsibilities
            _buildSection(
              'User Responsibilities',
              [
                'You are responsible for:',
                '• Accurately entering your prescribed IDDSI level as diagnosed by your SLP',
                '• Following all recommendations provided by your healthcare team',
                '• Monitoring your symptoms and reporting changes to your speech therapist',
                '• Seeking immediate medical attention in case of choking or breathing difficulties',
                '• Using the app as a supplementary tool, not as a replacement for professional medical care',
                '• Informing caregivers and family members about your dysphagia diagnosis and dietary restrictions',
              ],
            ),

            // Data Privacy
            _buildSection(
              'Data Privacy',
              [
                'Your personal information and health data are stored securely using Firebase.',
                'We collect and store: name, profile information, selected IDDSI level, language preferences, and app usage data.',
                'Your data is used solely to provide app functionality and improve user experience.',
                'We do not share your personal health information with third parties without your consent.',
                'You have the right to request deletion of your data at any time.',
              ],
            ),

            // App Limitations
            _buildSection(
              'App Limitations',
              [
                'This app is designed for use by patients with dysphagia who have been formally assessed and diagnosed by a qualified Speech-Language Pathologist.',
                'The app is intended for the South African context and follows IDDSI guidelines as adopted in South Africa.',
                'Information in the app may not be complete, up-to-date, or applicable to all situations.',
                'The AI chatbot provides general information and should not be considered personalized medical advice.',
                'Internet connection is required for full app functionality.',
              ],
            ),

            // Changes to Terms
            _buildSection(
              'Changes to Terms',
              [
                'We reserve the right to modify these Terms & Conditions at any time.',
                'Changes will be effective immediately upon posting in the app.',
                'Continued use of the app after changes constitutes acceptance of modified terms.',
                'It is your responsibility to review these terms periodically.',
              ],
            ),

            // Acceptance
            _buildSection(
              'Acceptance of Terms',
              [
                'By using the Dysphagia Care App, you acknowledge that:',
                '• You have read and understood these Terms & Conditions',
                '• You agree to all terms stated above',
                '• You have been diagnosed with dysphagia by a qualified healthcare professional',
                '• You understand the risks associated with dysphagia',
                '• You will use this app responsibly and as a supplementary tool only',
                '• You accept all liability and risk associated with using this app',
              ],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Questions or Concerns?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF44157F),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'If you have questions about these terms or the app, please contact:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Speech Therapy Department\nChris Hani Baragwanath Academic Hospital',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF44157F),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildImportantNotice() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF44157F).withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF44157F),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'IMPORTANT NOTICE',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF44157F),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'This app does NOT provide medical diagnosis. All dysphagia diagnoses MUST be made by qualified Speech-Language Pathologists.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'If you experience any discomfort after consuming suggested foods, STOP immediately and consult your Speech-Language Pathologist.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF44157F),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<String> points,
  ) {
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
          // Section Title
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF44157F),
              ),
            ),
          ),
          const SizedBox(height: 15),
          // Section Content
          ...points.map((point) => point.isEmpty
              ? const SizedBox(height: 10)
              : Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!point.startsWith('•'))
                        const Text(
                          '• ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF44157F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          point.startsWith('•') ? point.substring(2) : point,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}
