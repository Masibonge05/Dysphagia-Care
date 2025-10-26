import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<String> _categories = const [
    'All',
    'What Level do I use',
    'Implementation',
    'Questions About the Standard',
    'Questions About Testing',
  ];

  // Initialize as empty list first, populate in initState
  List<Map<String, dynamic>> _faqs = [];

  @override
  void initState() {
    super.initState();
    _faqs = _getFAQs();
  }

  List<Map<String, dynamic>> _getFAQs() {
    return [
      {
        'question': 'How do I know which level to recommend for a patient?',
        'answer': 'These are common questions we regularly receive. It is important to understand that: The IDDSI framework provides standardized descriptors for food textures and drink thickness. The appropriate level should be determined by a qualified Speech-Language Pathologist through clinical assessment. Factors considered include: swallowing ability, aspiration risk, oral motor function, and overall health status. Never self-diagnose or change levels without professional consultation.',
        'category': 'What Level do I use',
      },
      {
        'question': 'Is it okay to include X food or drink for a patient who is on diet Y?',
        'answer': 'Food and drink recommendations depend on multiple factors including the patient\'s prescribed IDDSI level, individual tolerance, medical conditions, and allergies. Always consult with your Speech-Language Pathologist before introducing new foods or drinks. Test new items in small amounts first under supervision. The app provides general guidelines, but individual assessment by a healthcare professional is essential.',
        'category': 'What Level do I use',
      },
      {
        'question': 'How do I know a particular food or drink is OK to offer?',
        'answer': 'Food/drinks vary in consistency depending on temperature, moisture, freshness/ripeness, method of cooking, and preparation. Always test the food texture using IDDSI testing methods (Fork Drip Test, Spoon Tilt Test, Fork Pressure Test, Chopstick Test) to ensure it meets the required level. Consider: How was it prepared? What temperature is it? Has it been sitting out? Individual foods within the same category can vary significantly. When in doubt, consult your speech therapist or test the consistency.',
        'category': 'What Level do I use',
      },
      {
        'question': 'My facility only uses two levels of drink thickness. Do we have to use all of the IDDSI drink thickness levels?',
        'answer': 'No, although the IDDSI framework includes five different levels of increasing drink thickness (Levels 0-4), there is no expectation that all facilities must use all five levels. Many facilities successfully use a subset of IDDSI levels. The key is consistency in terminology and testing methods. What matters is that when you say "mildly thick" (Level 2), it means the same thing everywhere, and you can verify it with IDDSI testing.',
        'category': 'Implementation',
      },
      {
        'question': 'I\'ve not heard of Level 1 - Slightly Thick before, what is this level?',
        'answer': 'Level 1 – Slightly Thick is predominantly used by paediatric clinicians and refers to the thickness that is just thicker than water but still flows easily. It is the least viscous of the thick drink levels. Think of it as similar to the consistency of buttermilk or a thin smoothie. In the IDDSI Flow Test, it flows slightly slower than thin drinks (Level 0) but still runs through the fork prongs. This level is useful for patients who need minimal thickening.',
        'category': 'Implementation',
      },
      {
        'question': 'My facility has used the terms "nectar" and "honey" for decades; why weren\'t these terms used in the IDDSI framework?',
        'answer': 'Two international stakeholder surveys were conducted regarding texture terminology, and received more than 2000 responses from 32 countries. The surveys revealed that terms like "nectar" and "honey" mean different things in different countries and regions. These food-based descriptors are problematic because: (1) Actual nectar and honey vary in thickness, (2) Different brands have different consistencies, (3) They don\'t translate well across languages and cultures. IDDSI chose descriptive terms (Slightly Thick, Mildly Thick, Moderately Thick, Extremely Thick) that can be universally understood and are based on measurable properties, not food comparisons.',
        'category': 'Implementation',
      },
      {
        'question': 'Why do Level 3 \'Liquidised\' foods and \'Moderately thick\' drinks share the same number and why do Level 4 \'Pureed\' foods and \'Extremely thick\' drinks share the same number?',
        'answer': 'During the testing phase of IDDSI framework development, the committee came to the realization that at Levels 3 and 4, drinks and foods have similar flow and texture properties that can be measured using the same tests. Level 3 Liquidised foods and Moderately Thick drinks both drip slowly through a fork and cannot hold their shape. Level 4 Pureed foods and Extremely Thick drinks both hold their shape on a spoon. This overlap reflects the physical reality that at these levels, the distinction between "food" and "drink" becomes blurred – they share similar consistencies.',
        'category': 'Questions About the Standard',
      },
      {
        'question': 'Won\'t fruit smoothies and liquidised soups clog up the syringe?',
        'answer': 'The official IDDSI recommendation is that products in Levels 0-4 should be smooth and homogeneous, without lumps, bits, or pieces. If a liquidised food or smoothie contains pulp, seeds, or pieces that could clog the syringe, it should be strained before testing. The Flow Test is designed for smooth liquids. If a product clogs the syringe, this is an indication that it may not be appropriate for individuals with swallowing difficulties, as those particles could pose an aspiration risk.',
        'category': 'Implementation',
      },
      {
        'question': 'What does a 10 ml Slip Tip syringe look like and can I be sure it is the same around the world?',
        'answer': 'A 10 ml \'slip tip\' syringe is shown in the IDDSI testing documentation. It is sold as a plastic sterile hypodermic syringe in most pharmacies and medical supply stores worldwide. The key features are: (1) 10ml capacity, (2) Slip tip (not Luer-Lok), (3) Standard diameter. The IDDSI committee chose this specific syringe because it has standardized dimensions globally. While different brands exist, they all conform to ISO standards, ensuring testing consistency across countries. You can find these at pharmacies – ask for a "10ml slip tip syringe."',
        'category': 'Implementation',
      },
      {
        'question': 'When I test the sample using the IDDSI Flow test I have exactly 8ml left in the syringe – is this Level 2 or Level 3?',
        'answer': 'The sample is neither Level 2 nor Level 3. A sample that tests at exactly the IDDSI cut-off point between categories is considered "borderline" and should be treated with caution. This indicates inconsistency in preparation or the need for recipe adjustment. For safety, treat borderline samples as the thicker category. If you consistently get borderline results, review your recipe and preparation method. Consistent results are important for patient safety – aim for measurements that fall clearly within one category.',
        'category': 'Questions About Testing',
      },
    ];
  }

  List<Map<String, dynamic>> get _filteredFAQs {
    return _faqs.where((faq) {
      final matchesSearch = _searchQuery.isEmpty ||
          faq['question'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          faq['answer'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesCategory = _selectedCategory == 'All' || faq['category'] == _selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
            // Header
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'Frequently Asked Questions',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Search bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search FAQs...',
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: Color(0xFF44157F)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Category pills
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
                              )
                            : null,
                        color: isSelected ? null : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF44157F),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // FAQ List
            Expanded(
              child: _filteredFAQs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
                          const SizedBox(height: 20),
                          const Text(
                            'No FAQs found',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Try a different search or category',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: _filteredFAQs.length,
                      itemBuilder: (context, index) {
                        final faq = _filteredFAQs[index];
                        return _buildFAQCard(
                          faq['question'],
                          faq['answer'],
                          faq['category'],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQCard(String question, String answer, String category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(20),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF44157F).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.help_outline, color: Color(0xFF44157F)),
          ),
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Category: $category',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Color(0xFF333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}