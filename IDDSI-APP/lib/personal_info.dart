import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'language_selection.dart'; // Import the language selection page

class IDDSIPersonalInfoPage extends StatefulWidget {
  const IDDSIPersonalInfoPage({super.key});

  @override
  _IDDSIPersonalInfoPageState createState() => _IDDSIPersonalInfoPageState();
}

class _IDDSIPersonalInfoPageState extends State<IDDSIPersonalInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  String? selectedLevel; // Only one level can be selected total
  bool isLoading = false;

  // All level options combined
  final List<Map<String, dynamic>> allLevels = [
    {'value': 'fluid_0', 'label': 'Level 0: Thin', 'category': 'Fluids', 'level': '0'},
    {'value': 'fluid_1', 'label': 'Level 1: Slightly Thick', 'category': 'Fluids', 'level': '1'},
    {'value': 'fluid_2', 'label': 'Level 2: Mildly Thick', 'category': 'Fluids', 'level': '2'},
    {'value': 'fluid_3', 'label': 'Level 3: Moderately Thick', 'category': 'Fluids', 'level': '3'},
    {'value': 'fluid_4', 'label': 'Level 4: Extremely Thick', 'category': 'Fluids', 'level': '4'},
    {'value': 'food_3', 'label': 'Level 3: Liquidised', 'category': 'Food', 'level': '3'},
    {'value': 'food_4', 'label': 'Level 4: Puréed', 'category': 'Food', 'level': '4'},
    {'value': 'food_5', 'label': 'Level 5: Minced and Moist', 'category': 'Food', 'level': '5'},
    {'value': 'food_6', 'label': 'Level 6: Soft and Bite-Sized', 'category': 'Food', 'level': '6'},
    {'value': 'food_7', 'label': 'Level 7: Regular', 'category': 'Food', 'level': '7'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _savePersonalInfo() async {
    if (_nameController.text.trim().isEmpty ||
        _ageController.text.trim().isEmpty ||
        selectedLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields and select your level'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Parse the selected level to determine category and level
        final selectedLevelData = allLevels.firstWhere((level) => level['value'] == selectedLevel);
        final category = selectedLevelData['category'].toLowerCase();
        final levelValue = selectedLevelData['level'];

        Map<String, dynamic> userData = {
          'name': _nameController.text.trim(),
          'age': int.tryParse(_ageController.text.trim()) ?? 0,
          'selectedLevel': selectedLevel,
          'selectedCategory': category,
          'selectedLevelValue': levelValue,
          'email': user.email,
          'updatedAt': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
        };

        // For backward compatibility, also set the old fields
        if (category == 'fluids') {
          userData['fluidLevel'] = levelValue;
          userData['foodLevel'] = null;
        } else {
          userData['foodLevel'] = levelValue;
          userData['fluidLevel'] = null;
        }

        await _firestore.collection('users').doc(user.uid).set(userData, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Personal information saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to language selection page
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const LanguageSelectionPage())
        );
        
      } else {
        throw Exception('User not authenticated');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving information: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildRadioGroup(String title, List<Map<String, dynamic>> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF01224F),
          ),
        ),
        const SizedBox(height: 12),
        ...options.map((option) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Radio<String>(
                value: option['value']!,
                groupValue: selectedLevel,
                onChanged: (value) {
                  setState(() {
                    selectedLevel = value;
                  });
                },
                activeColor: const Color(0xFF01224F),
                fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Color(0xFF01224F);
                  }
                  return Colors.white;
                }),
              ),
              Expanded(
                child: Text(
                  option['label']!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF01224F),
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter levels by category for display
    final fluidLevels = allLevels.where((level) => level['category'] == 'Fluids').toList();
    final foodLevels = allLevels.where((level) => level['category'] == 'Food').toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset(
                'assets/images/background.png',
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading background image: $error');
                  return Container(
                    color: const Color(0xFFE3F2FD),
                    child: const Center(child: Text('Image load failed')),
                  );
                },
              ),
            ),
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF01224F),
                ),
              ),
              const SizedBox(height: 30),
              
              // Name Input Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF00529A), width: 2),
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Insert Name',
                    hintStyle: TextStyle(color: Color(0xFF00529A)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF01224F),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Age Input Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF00529A), width: 2),
                ),
                child: TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Insert Age',
                    hintStyle: TextStyle(color: Color(0xFF00529A)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF01224F),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              const Text(
                'Please Select Your Level (Choose Only One)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF01224F),
                ),
              ),
              const SizedBox(height: 24),
              
              // Fluids Section
              _buildRadioGroup('Fluids', fluidLevels),
              const SizedBox(height: 24),
              
              // Food Section
              _buildRadioGroup('Food', foodLevels),
              const SizedBox(height: 40),
              
              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF01224F),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  onPressed: isLoading ? null : _savePersonalInfo,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
        ],
      ),
    );
  }
}