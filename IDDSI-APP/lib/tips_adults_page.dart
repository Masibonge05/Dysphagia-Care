import 'package:flutter/material.dart';

class TipsAdultsPage extends StatefulWidget {
  const TipsAdultsPage({super.key});

  @override
  State<TipsAdultsPage> createState() => _TipsAdultsPageState();
}

class _TipsAdultsPageState extends State<TipsAdultsPage> {
  // Track expanded sections
  final Map<String, bool> _expandedSections = {
    'eating': false,
    'drinking': false,
    'mealtime': false,
    'posture': false,
    'food': false,
    'medication': false,
    'socializing': false,
    'caregiver': false,
    'emergency': false,
    'nutrition': false,
  };

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
          'Tips for Older Adults',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF44157F),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Banner - Simplified
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF44157F),
              ),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: const Column(
                children: [
                  Text(
                    'Tips for Older Adults',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Safe Eating & Drinking Strategies',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Introduction Card - Simplified
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
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
                          'Important Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44157F),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'These tips are designed to help older adults with dysphagia eat and drink safely. Always follow your Speech-Language Pathologist\'s recommendations for your specific needs.',
                          style: TextStyle(fontSize: 15, height: 1.6),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Safe Eating Strategies
                  _buildExpandableSection(
                    key: 'eating',
                    title: 'Safe Eating Strategies',
                    icon: Icons.restaurant_menu,
                    color: const Color(0xFF44157F),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTipCard(
                          '1. Take Small Bites',
                          'Use a teaspoon instead of a tablespoon. Small amounts are easier to control and swallow safely.',
                        ),
                        _buildTipCard(
                          '2. Eat Slowly',
                          'Take your time. There\'s no rush! Eating slowly reduces choking risk and helps with digestion.',
                        ),
                        _buildTipCard(
                          '3. Chew Thoroughly',
                          'Chew food until it\'s very soft before swallowing. This is especially important for solid foods.',
                        ),
                        _buildTipCard(
                          '4. Swallow Twice',
                          'After swallowing once, try swallowing again to make sure your mouth and throat are completely clear.',
                        ),
                        _buildTipCard(
                          '5. Don\'t Talk While Eating',
                          'Finish chewing and swallowing before speaking. This prevents food from going down the wrong way.',
                        ),
                        _buildTipCard(
                          '6. Avoid Distractions',
                          'Turn off the TV and focus on eating. Pay attention to the taste, texture, and swallowing.',
                        ),
                      ],
                    ),
                  ),

                  // Safe Drinking Tips
                  _buildExpandableSection(
                    key: 'drinking',
                    title: 'Safe Drinking Tips',
                    icon: Icons.local_drink,
                    color: const Color(0xFF44157F),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTipCard(
                          '1. Small Sips Only',
                          'Take tiny sips - about 5ml (one teaspoon). Large gulps increase choking risk.',
                        ),
                        _buildTipCard(
                          '2. Use the Right Thickness',
                          'Follow your SLP\'s advice on liquid thickness (IDDSI levels). Never thin liquids on your own.',
                        ),
                        _buildTipCard(
                          '3. Use a Small Cup',
                          'Small cups or medicine cups help control how much liquid you take at once.',
                        ),
                        _buildTipCard(
                          '4. Avoid Straws (Usually)',
                          'Unless your SLP recommends them, straws can make liquid flow too fast. Ask your therapist.',
                        ),
                        _buildTipCard(
                          '5. Wait Between Sips',
                          'Give yourself time between sips. This helps prevent liquid buildup in your throat.',
                        ),
                        _buildTipCard(
                          '6. Keep Liquids Separate',
                          'Don\'t mix thin and thick liquids in the same cup. Stick to your prescribed consistency.',
                        ),
                      ],
                    ),
                  ),

                  // Mealtime Environment
                  _buildExpandableSection(
                    key: 'mealtime',
                    title: 'Mealtime Environment',
                    icon: Icons.chair,
                    color: const Color(0xFF44157F),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTipCard(
                          '1. Quiet, Calm Space',
                          'Eat in a quiet room without TV or loud music. This helps you focus on swallowing safely.',
                        ),
                        _buildTipCard(
                          '2. Good Lighting',
                          'Make sure the room is well-lit so you can see your food clearly.',
                        ),
                        _buildTipCard(
                          '3. Comfortable Temperature',
                          'Keep the room at a comfortable temperature - not too hot or cold.',
                        ),
                        _buildTipCard(
                          '4. Remove Distractions',
                          'Put away phones, tablets, and books during meals.',
                        ),
                        _buildTipCard(
                          '5. Take Your Time',
                          'Allow at least 30-45 minutes for meals. Never rush!',
                        ),
                      ],
                    ),
                  ),

                  // Posture and Positioning
                  _buildExpandableSection(
                    key: 'posture',
                    title: 'Posture and Positioning',
                    icon: Icons.accessibility_new,
                    color: const Color(0xFF44157F),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTipCard(
                          '1. Sit Upright',
                          'Sit up straight at 90 degrees. Never eat lying down or slouching.',
                        ),
                        _buildTipCard(
                          '2. Feet on Floor',
                          'Keep both feet flat on the floor or on a footrest. This helps maintain good posture.',
                        ),
                        _buildTipCard(
                          '3. Tuck Your Chin',
                          'Slightly tuck your chin down toward your chest when swallowing (unless told otherwise).',
                        ),
                        _buildTipCard(
                          '4. Stay Upright After',
                          'Remain sitting upright for at least 30 minutes after eating or drinking.',
                        ),
                        _buildTipCard(
                          '5. Use Support if Needed',
                          'Use cushions or pillows to maintain good posture if needed.',
                        ),
                      ],
                    ),
                  ),

                  // Food Texture and Preparation
                  _buildExpandableSection(
                    key: 'food',
                    title: 'Food Texture and Preparation',
                    icon: Icons.food_bank,
                    color: const Color(0xFF44157F),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTipCard(
                          '1. Follow Your Diet Level',
                          'Stick to the IDDSI texture level recommended by your SLP. Don\'t guess!',
                        ),
                        _buildTipCard(
                          '2. Moist Foods Are Safer',
                          'Add gravy, sauce, or broth to keep foods moist. Dry foods are harder to swallow.',
                        ),
                        _buildTipCard(
                          '3. Avoid Mixed Textures',
                          'Don\'t eat foods with different textures together (like cereal with milk).',
                        ),
                        _buildTipCard(
                          '4. Watch Temperature',
                          'Extreme temperatures (very hot or cold) can affect swallowing. Warm is usually best.',
                        ),
                        _buildTipCard(
                          '5. Test Before Eating',
                          'Use the IDDSI testing methods to check if food is the right texture.',
                        ),
                      ],
                    ),
                  ),

                  // Medication Safety
                  _buildExpandableSection(
                    key: 'medication',
                    title: 'Medication Safety',
                    icon: Icons.medication,
                    color: const Color(0xFF44157F),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImportantBox(
                          'Always consult your doctor or pharmacist before changing how you take medications!',
                        ),
                        const SizedBox(height: 15),
                        _buildTipCard(
                          '1. Ask About Liquid Forms',
                          'Many medications come in liquid form. Ask your pharmacist if this is available.',
                        ),
                        _buildTipCard(
                          '2. Crushable Pills',
                          'Some pills can be crushed, but NEVER crush without asking first. Some medications are dangerous if crushed.',
                        ),
                        _buildTipCard(
                          '3. Use Thickened Liquid',
                          'If you need thickened liquids, use them for medications too (after checking with your pharmacist).',
                        ),
                        _buildTipCard(
                          '4. Take One at a Time',
                          'Take medications one pill at a time, never several together.',
                        ),
                        _buildTipCard(
                          '5. Stay Upright After',
                          'Remain sitting upright for 30 minutes after taking medication.',
                        ),
                      ],
                    ),
                  ),

                  // Socializing While Eating
                  _buildExpandableSection(
                    key: 'socializing',
                    title: 'Socializing While Eating',
                    icon: Icons.people,
                    color: const Color(0xFF44157F),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTipCard(
                          '1. Talk Between Bites',
                          'Enjoy conversations, but only talk when your mouth is empty. Never talk while chewing.',
                        ),
                        _buildTipCard(
                          '2. Let Others Know',
                          'Tell dining companions about your swallowing needs. They\'ll understand if you eat slowly.',
                        ),
                        _buildTipCard(
                          '3. Don\'t Feel Rushed',
                          'If others finish before you, that\'s okay! Take the time you need.',
                        ),
                        _buildTipCard(
                          '4. Focus on Safety First',
                          'Being social is wonderful, but safe swallowing is more important.',
                        ),
                      ],
                    ),
                  ),

                  // For Caregivers
                  _buildExpandableSection(
                    key: 'caregiver',
                    title: 'For Caregivers',
                    icon: Icons.family_restroom,
                    color: const Color(0xFF44157F),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTipCard(
                          '1. Supervise Meals',
                          'Stay with the person during meals and for 30 minutes after.',
                        ),
                        _buildTipCard(
                          '2. Watch for Signs of Trouble',
                          'Learn the signs of choking and aspiration. Act quickly if you see them.',
                        ),
                        _buildTipCard(
                          '3. Prepare Food Correctly',
                          'Follow the prescribed texture guidelines exactly. When in doubt, ask the SLP.',
                        ),
                        _buildTipCard(
                          '4. Create a Calm Environment',
                          'Minimize distractions during mealtimes. Turn off TV and reduce noise.',
                        ),
                        _buildTipCard(
                          '5. Be Patient',
                          'Never rush the person. Eating safely takes time.',
                        ),
                        _buildTipCard(
                          '6. Encourage Independence',
                          'Let them do what they can safely do themselves. Offer help when needed.',
                        ),
                        const SizedBox(height: 15),
                        _buildWarningBox(
                          'If the person refuses to follow safety strategies or shows signs of confusion about eating, contact their healthcare provider.',
                        ),
                      ],
                    ),
                  ),

                  // Emergency Information
                  _buildExpandableSection(
                    key: 'emergency',
                    title: 'Emergency Information',
                    icon: Icons.emergency,
                    color: const Color(0xFFB71C1C),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildEmergencyBox(
                          'Signs of Choking',
                          [
                            'Cannot breathe or speak',
                            'Gasping for air',
                            'Clutching throat with hands',
                            'Face turning blue or purple',
                            'Making high-pitched sounds',
                            'Silent coughing (no sound)',
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'If Someone is Choking:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB71C1C),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildEmergencyCard(
                          'Call Emergency Services',
                          'Call 911 or your local emergency number immediately.',
                          '1',
                        ),
                        _buildEmergencyCard(
                          'Perform Heimlich Maneuver',
                          'If trained, perform abdominal thrusts (Heimlich maneuver). If not trained, stay on the line with emergency services for instructions.',
                          '2',
                        ),
                        _buildEmergencyCard(
                          'For Unconscious Person',
                          'If they become unconscious, lay them flat and begin CPR if you\'re trained. Stay on the line with emergency services.',
                          '3',
                        ),
                        const SizedBox(height: 15),
                        _buildEmergencyBox(
                          'Signs of Aspiration (Silent)',
                          [
                            'Coughing during or after eating/drinking',
                            'Wet or gurgly voice after swallowing',
                            'Feeling like food is stuck',
                            'Frequent throat clearing',
                            'Shortness of breath',
                            'Fever developing hours after eating',
                          ],
                        ),
                        const SizedBox(height: 15),
                        _buildWarningBox(
                          'If you notice any signs of aspiration, contact your healthcare provider immediately. Repeated aspiration can lead to pneumonia.',
                        ),
                      ],
                    ),
                  ),

                  // Nutrition and Hydration
                  _buildExpandableSection(
                    key: 'nutrition',
                    title: 'Nutrition and Hydration',
                    icon: Icons.water_drop,
                    color: const Color(0xFF44157F),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTipCard(
                          '1. Eat Regular Meals',
                          'Try to eat 3 meals and 2-3 snacks daily, even if portions are small.',
                        ),
                        _buildTipCard(
                          '2. Stay Hydrated',
                          'Drink throughout the day. Sip frequently rather than drinking large amounts at once.',
                        ),
                        _buildTipCard(
                          '3. Nutrient-Dense Foods',
                          'Choose foods high in calories and protein. Every bite counts!',
                        ),
                        _buildTipCard(
                          '4. Monitor Weight',
                          'Weigh yourself weekly. Report weight loss to your healthcare provider.',
                        ),
                        _buildTipCard(
                          '5. Consider Supplements',
                          'Ask your doctor about nutritional supplements if you\'re not eating enough.',
                        ),
                        const SizedBox(height: 15),
                        _buildInfoBox(
                          'Dehydration Warning',
                          'Signs of dehydration include: dark urine, dizziness, confusion, dry mouth, and fatigue. If you experience these, contact your healthcare provider.',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Final Note
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF44157F).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF44157F).withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Remember',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF44157F),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'These are general guidelines. Your Speech-Language Pathologist will provide specific recommendations based on your swallowing evaluation. Always follow their advice and report any new difficulties or concerns immediately.',
                          style: TextStyle(fontSize: 15, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String key,
    required String title,
    required IconData icon,
    required Color color,
    required Widget content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
                _expandedSections[key] = !_expandedSections[key]!;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  Icon(
                    _expandedSections[key]!
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: color,
                  ),
                ],
              ),
            ),
          ),
          if (_expandedSections[key]!)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: content,
            ),
        ],
      ),
    );
  }

  Widget _buildTipCard(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF44157F).withOpacity(0.1),
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
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF555555),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyCard(
      String title, String description, String stepNumber) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFB71C1C).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFB71C1C).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFB71C1C),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                stepNumber,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
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
                    color: Color(0xFFB71C1C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyBox(String title, List<String> signs) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFB71C1C).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFB71C1C).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB71C1C),
            ),
          ),
          const SizedBox(height: 12),
          ...signs.map((sign) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB71C1C),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        sign,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
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

  Widget _buildWarningBox(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF44157F).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF44157F).withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: Color(0xFF44157F),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF44157F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImportantBox(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF44157F).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF44157F).withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.priority_high,
            color: Color(0xFF44157F),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF44157F),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
