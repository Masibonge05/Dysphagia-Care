import 'package:flutter/material.dart';

class LevelData {
  final String value;
  final String label;
  final String category;
  final String levelNumber;
  final Color color;
  final List<FoodSuggestion> foodSuggestions;

  LevelData({
    required this.value,
    required this.label,
    required this.category,
    required this.levelNumber,
    required this.color,
    required this.foodSuggestions,
  });

  get name => null;

  get characteristics => null;
}

class FoodSuggestion {
  final String image;
  final String name;

  FoodSuggestion({
    required this.image,
    required this.name,
  });

  get icon => null;

  String? get emoji => null;
}

class LevelDataProvider {
  static final Map<String, LevelData> _levelsData = {
    // Fluid Levels
    'fluid_0': LevelData(
      value: 'fluid_0',
      label: 'Level 0: Thin',
      category: 'Fluids',
      levelNumber: '0',
      color: const Color.fromARGB(255, 255, 255, 255), 
      foodSuggestions: [
        FoodSuggestion(
          image: 'assets/food/apple_juice.png',
          name: 'Apple Juice',
        ),
        FoodSuggestion(
          image: 'assets/food/milk.jpg',
          name: 'Milk',
        ),
        FoodSuggestion(
          image: 'assets/food/tea.png',
          name: 'Tea',
        ),
        FoodSuggestion(
          image: 'assets/food/coffee.png',
          name: 'Coffee',
        ),
        FoodSuggestion(
          image: 'assets/food/fresubin-original.png',
          name: 'Fresubin Original',
        ),
        FoodSuggestion(
          image: 'assets/food/supportan.webp',
          name: 'Supportan',
        ),
        FoodSuggestion(
          image: 'assets/food/fresubin_protein.webp',
          name: 'Fresubin Protein',
        ),
        FoodSuggestion(
          image: 'assets/food/tropika.webp',
          name: 'Tropika',
        ),
        FoodSuggestion(
          image: 'assets/food/coke_zero.jpg',
          name: 'Coke Zero',
        ),
      ],
    ),
    



    'fluid_1': LevelData(
      value: 'fluid_1',
      label: 'Level 1: Slightly Thick',
      category: 'Fluids',
      levelNumber: '1',
      color: const Color(0xFF616566), 
      foodSuggestions: [
        FoodSuggestion(
          image: 'assets/food/sir_mango_juice.webp',
          name: 'Sir Mango Juice',
        ),
      ],
    ),



    'fluid_2': LevelData(
      value: 'fluid_2',
      label: 'Level 2: Mildly Thick',
      category: 'Fluids',
      levelNumber: '2',
      color: const Color(0xFFEE60A2), 
      foodSuggestions: [
        FoodSuggestion(
          image: 'assets/food/thick_smoothie.png',
          name: 'Thick Smoothie',
        ),
      ],
    ),



    'fluid_3': LevelData(
      value: 'fluid_3',
      label: 'Level 3: Moderately Thick',
      category: 'Fluids',
      levelNumber: '3',
      color: const Color(0xFFE8D900), // Gold
      foodSuggestions: [
        FoodSuggestion(
          image: 'assets/food/purity_peach.jpeg',
          name: 'Purity Peach',
        ),
        FoodSuggestion(
          image: 'assets/food/clover_custard.png',
          name: 'Clover Custard',
        ),
        FoodSuggestion(
          image: 'assets/food/yogi_sip.jpeg',
          name: 'Yogi Sip',
        ),
        FoodSuggestion(
          image: 'assets/food/mageu.png',
          name: 'Mageu',
        ),
      ],
    ),


    'fluid_4': LevelData(
      value: 'fluid_4',
      label: 'Level 4: Extremely Thick',
      category: 'Fluids',
      levelNumber: '4',
      color: const Color(0xFF76C04F), 
      foodSuggestions: [
        FoodSuggestion(
          image: 'assets/food/mashed_potatoes.jpg',
          name: 'Mashed Potatoes',
        ),
        FoodSuggestion(
          image: 'assets/food/mashed_bananas.jpg',
          name: 'Mashed Bananas',
        ),
        FoodSuggestion(
          image: 'assets/food/purity_vegetable_beef.webp',
          name: 'Purity Vegetable and Beef',
        ),
      ],
    ),



    // Food Levels
    'food_3': LevelData(
      value: 'food_3',
      label: 'Level 3: Liquidised',
      category: 'Food',
      levelNumber: '3',
      color: const Color(0xFFE8D900), 
      foodSuggestions: [
        FoodSuggestion(
          image: 'assets/food/purity_peach.jpeg',
          name: 'Purity Peach',
        ),
        FoodSuggestion(
          image: 'assets/food/clover_custard.png',
          name: 'Clover Custard',
        ),
        FoodSuggestion(
          image: 'assets/food/yogi_sip.jpeg',
          name: 'Yogi Sip',
        ),
        FoodSuggestion(
          image: 'assets/food/mageu.png',
          name: 'Mageu',
        ),
      ],
    ),



    'food_4': LevelData(
      value: 'food_4',
      label: 'Level 4: Puréed',
      category: 'Food',
      levelNumber: '4',
      color: const Color(0xFF76C04F), 
      foodSuggestions: [
        FoodSuggestion(
          image: 'assets/food/mashed_potatoes.jpg',
          name: 'Mashed Potatoes',
        ),
        FoodSuggestion(
          image: 'assets/food/mashed_bananas.jpg',
          name: 'Mashed Bananas',
        ),
        FoodSuggestion(
          image: 'assets/food/purity_vegetable_beef.webp',
          name: 'Purity Vegetable and Beef',
        ),
      ],
    ),



    'food_5': LevelData(
      value: 'food_5',
      label: 'Level 5: Minced and Moist',
      category: 'Food',
      levelNumber: '5',
      color: const Color(0xFFF0763D), 
      foodSuggestions: [
        FoodSuggestion(
          image: 'assets/food/mashed_papaya.jpg',
          name: 'Mashed Papaya',
        ),
        FoodSuggestion(
          image: 'assets/food/mince.jpg',
          name: 'Mince',
        ),
      ],
    ),



    'food_6': LevelData(
      value: 'food_6',
      label: 'Level 6: Soft and Bite-Sized',
      category: 'Food',
      levelNumber: '6',
      color: const Color(0xFF0175BC), 
      foodSuggestions: [
        FoodSuggestion(
          image: 'assets/food/soft_vegetables.jpg',
          name: 'Soft Vegetables',
        ),
        FoodSuggestion(
          image: 'assets/food/samp.webp',
          name: 'Samp',
        ),
        FoodSuggestion(
          image: 'assets/food/pap.jpeg',
          name: 'Pap',
        ),
        FoodSuggestion(
          image: 'assets/food/bread.jpg',
          name: 'Bread',
        ),
        FoodSuggestion(
          image: 'assets/food/shredded_chicken.jpg',
          name: 'Shredded Chicken',
        ),
        FoodSuggestion(
          image: 'assets/food/weetabix.png',
          name: 'Weetbix',
        ),
        FoodSuggestion(
          image: 'assets/food/rice.jpg',
          name: 'Rice',
        ),
      ],
    ),





    'food_7': LevelData(
      value: 'food_7',
      label: 'Level 7: Regular',
      category: 'Food',
      levelNumber: '7',
      color: const Color(0xFF2E2E31), 
      foodSuggestions: [
        FoodSuggestion(
          image: 'assets/food/fried_rice.jpg',
          name: 'Fried Rice',
        ),
        FoodSuggestion(
          image: 'assets/food/vegetarian_stew.png',
          name: 'Vegetarian Stew',
        ),
        FoodSuggestion(
          image: 'assets/food/potato_chips.jpg',
          name: 'Potato Chips',
        ),
        FoodSuggestion(
          image: 'assets/food/burger.jpg',
          name: 'Burger',
        ),
        FoodSuggestion(
          image: 'assets/food/fried_chicken.jpg',
          name: 'Fried Chicken',
        ),

      ],
    ),
  };

  // Get level data by value
  static LevelData? getLevelData(String levelValue) {
    return _levelsData[levelValue];
  }

  // Get all levels
  static Map<String, LevelData> getAllLevels() {
    return _levelsData;
  }

  // Get levels by category
  static List<LevelData> getLevelsByCategory(String category) {
    return _levelsData.values
        .where((level) => level.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  // Get level display name
  static String getLevelDisplayName(String levelValue) {
    final levelData = _levelsData[levelValue];
    return levelData?.label ?? 'Unknown Level';
  }

  // Get level color
  static Color getLevelColor(String levelValue) {
    final levelData = _levelsData[levelValue];
    return levelData?.color ?? const Color(0xFFFFD700);
  }

  // Get food suggestions for a level
  static List<FoodSuggestion> getFoodSuggestions(String levelValue) {
    final levelData = _levelsData[levelValue];
    return levelData?.foodSuggestions ?? [];
  }
}