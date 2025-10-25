import 'package:flutter/material.dart';

class DysphagiaInfoPage extends StatefulWidget {
  const DysphagiaInfoPage({super.key});

  @override
  State<DysphagiaInfoPage> createState() => _DysphagiaInfoPageState();
}

class _DysphagiaInfoPageState extends State<DysphagiaInfoPage> {
  // Track expanded sections
  final Map<String, bool> _expandedSections = {
    'whatIs': false,
    'causes': false,
    'symptoms': false,
    'diagnosis': false,
    'treatment': false,
    'prevention': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Understanding Dysphagia',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF44157F),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Banner
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(30),
              child: const Column(
                children: [
                  Text(
                    'Dysphagia',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Swallowing Difficulties',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Quick Stats
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
                      children: [
                        const Text(
                          'In South Africa',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44157F),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatCard(
                                '~22%', 'Stroke patients\nhave dysphagia'),
                            _buildStatCard(
                                '50%+', 'Nursing home\nresidents affected'),
                            _buildStatCard(
                                '1 in 17', 'People will\ndevelop dysphagia'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // What is Dysphagia
                  _buildExpandableSection(
                    key: 'whatIs',
                    title: 'What is Dysphagia?',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dysphagia is a medical term for difficulty swallowing. It means that it takes more time and effort to move food or liquid from your mouth to your stomach.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildInfoBox(
                          'Medical Definition',
                          'A disorder characterized by difficulty in swallowing. It may be caused by neurological, structural, or functional abnormalities.',
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Types of Dysphagia:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44157F),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildBulletPoint('Oropharyngeal Dysphagia',
                            'Difficulty moving food from mouth to throat (upper dysphagia)'),
                        _buildBulletPoint('Esophageal Dysphagia',
                            'Difficulty moving food down the esophagus to stomach (lower dysphagia)'),
                      ],
                    ),
                  ),

                  // Causes
                  _buildExpandableSection(
                    key: 'causes',
                    title: 'What Causes Dysphagia?',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Common Causes in South Africa:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44157F),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildCauseCard(
                          'Stroke (CVA)',
                          'Leading cause in SA. About 22% of stroke patients develop dysphagia.',
                        ),
                        _buildCauseCard(
                          'HIV/AIDS',
                          'Can cause oral and esophageal infections leading to swallowing problems.',
                        ),
                        _buildCauseCard(
                          'Tuberculosis',
                          'Esophageal TB can cause swallowing difficulties.',
                        ),
                        _buildCauseCard(
                          'Head & Neck Cancer',
                          'Treatment and surgery can affect swallowing.',
                        ),
                        _buildCauseCard(
                          'Neurological Conditions',
                          'Parkinson\'s, dementia, MS, and motor neuron disease.',
                        ),
                        _buildCauseCard(
                          'Aging',
                          'Natural weakening of throat muscles (presbyphagia).',
                        ),
                      ],
                    ),
                  ),

                  // Symptoms
                  _buildExpandableSection(
                    key: 'symptoms',
                    title: 'Signs & Symptoms',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWarningBox(
                          'Warning Signs',
                          [
                            'Coughing or choking when eating or drinking',
                            'Bringing food back up through the nose',
                            'Feeling like food is stuck in throat',
                            'Wet or gurgly voice after swallowing',
                            'Taking a long time to chew or swallow',
                            'Avoiding certain foods or drinks',
                            'Unexplained weight loss',
                            'Recurrent chest infections or pneumonia',
                            'Difficulty breathing while eating',
                            'Drooling or difficulty managing saliva',
                          ],
                        ),
                        const SizedBox(height: 15),
                        _buildDangerBox(
                          'EMERGENCY: Seek immediate help if:',
                          [
                            'Complete inability to swallow',
                            'Severe breathing difficulty',
                            'Blue skin (cyanosis)',
                            'Loss of consciousness',
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Diagnosis in SA
                  _buildExpandableSection(
                    key: 'diagnosis',
                    title: 'Diagnosis in South Africa',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Healthcare Professionals Who Can Help:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44157F),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildProfessionalCard(
                          'Speech-Language Pathologist (SLP)',
                          'Primary specialist for dysphagia assessment and management. Also called Speech Therapists.',
                          'Available at: Public hospitals, private practices, rehabilitation centers',
                        ),
                        _buildProfessionalCard(
                          'Dietitian',
                          'Helps with nutritional management and food texture modifications.',
                          'Available at: Hospitals, clinics, private practices',
                        ),
                        _buildProfessionalCard(
                          'Occupational Therapist',
                          'Assists with adaptive equipment and feeding strategies.',
                          'Available at: Rehabilitation centers, hospitals',
                        ),
                        _buildProfessionalCard(
                          'ENT Specialist',
                          'Diagnoses structural problems affecting swallowing.',
                          'Available at: Specialist hospitals, private practices',
                        ),
                        const SizedBox(height: 15),
                        _buildInfoBox(
                          'Access in SA',
                          'Public sector: Available at district, regional, and tertiary hospitals\nPrivate sector: Medical aid may cover consultations\nNGOs: Organizations like ASHA SA provide support',
                        ),
                      ],
                    ),
                  ),

                  // Treatment & Management
                  _buildExpandableSection(
                    key: 'treatment',
                    title: 'Treatment & Management',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Treatment approaches depend on the cause and severity of dysphagia:',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildTreatmentCard(
                          'Swallowing Therapy',
                          'Exercises to strengthen swallowing muscles and improve coordination',
                        ),
                        _buildTreatmentCard(
                          'Diet Modifications',
                          'Adjusting food and liquid textures for safer swallowing',
                        ),
                        _buildTreatmentCard(
                          'Positioning Strategies',
                          'Specific postures and techniques during meals',
                        ),
                        _buildTreatmentCard(
                          'Medical Treatment',
                          'Addressing underlying causes (medication, surgery if needed)',
                        ),
                        _buildTreatmentCard(
                          'Compensatory Strategies',
                          'Techniques to make swallowing safer and more efficient',
                        ),
                      ],
                    ),
                  ),

                  // Prevention
                  _buildExpandableSection(
                    key: 'prevention',
                    title: 'Prevention & Safety',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'While not all dysphagia can be prevented, these measures can help reduce risk:',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildBulletPoint('Eat slowly and chew thoroughly', ''),
                        _buildBulletPoint('Take small bites and sips', ''),
                        _buildBulletPoint('Sit upright during meals', ''),
                        _buildBulletPoint(
                            'Stay for 30 minutes upright after eating', ''),
                        _buildBulletPoint('Avoid talking while eating', ''),
                        _buildBulletPoint(
                            'Manage underlying health conditions', ''),
                        _buildBulletPoint('Regular dental care', ''),
                        _buildBulletPoint('Stay hydrated', ''),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

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
                          'IMPORTANT',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44157F),
                            letterSpacing: 1.1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'This information is for educational purposes only. If you suspect you have dysphagia, consult a qualified Speech-Language Pathologist for proper assessment and diagnosis.',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF44157F).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF44157F),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String key,
    required String title,
    required Widget content,
  }) {
    final isExpanded = _expandedSections[key] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
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
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedSections[key] = !isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF44157F),
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: const Color(0xFF44157F),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: content,
            ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF44157F).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF44157F).withOpacity(0.3),
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
              height: 1.5,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCauseCard(String title, String description) {
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
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningBox(String title, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF44157F).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF44157F).withOpacity(0.3),
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
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        item,
                        style: const TextStyle(
                          fontSize: 14,
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

  Widget _buildDangerBox(String title, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF44157F).withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF44157F),
          width: 2,
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
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF44157F),
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

  Widget _buildProfessionalCard(
      String title, String description, String availability) {
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
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            availability,
            style: const TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentCard(String title, String description) {
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
                    fontSize: 14,
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
}
