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
}

class FoodSuggestion {
  final String image;
  final String name;

  FoodSuggestion({
    required this.image,
    required this.name,
  });
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
          image: 'assets/food/apple_juice.jpg',
          name: 'Apple Juice',
        ),
        FoodSuggestion(
          image: 'assets/food/milk.jpg',
          name: 'Milk',
        ),
        FoodSuggestion(
          image: 'assets/food/tea.jpg',
          name: 'Tea',
        ),
        FoodSuggestion(
          image: 'assets/food/coffee.jpg',
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
        FoodSuggestion(
          image: 'assets/food/thick_juice.png',
          name: 'Mildly Thick Juice',
        ),
        FoodSuggestion(
          image: 'assets/food/drinking_yogurt.png',
          name: 'Drinking Yogurt',
        ),
        FoodSuggestion(
          image: 'assets/food/thick_milkshake.png',
          name: 'Thick Milkshake',
        ),
        FoodSuggestion(
          image: 'assets/food/thick_soup.png',
          name: 'Cream Soup',
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
          image: 'assets/food/smooth_maize_porride.png',
          name: 'Smooth Maize Porridge',
        ),
        FoodSuggestion(
          image: 'assets/food/liquidised_shicken_soup.png',
          name: 'Liquidised Chicken Soup',
        ),
        FoodSuggestion(
          image: 'assets/food/custard.png',
          name: 'Smooth Custard',
        ),
        FoodSuggestion(
          image: 'assets/food/mageu.png',
          name: 'Traditional Mageu',
        ),
        FoodSuggestion(
          image: 'assets/food/pureed_vegetable_curry.png',
          name: 'Pureed Vegetable Curry',
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
          image: 'assets/food/thick_custard.png',
          name: 'Thick Custard',
        ),
        FoodSuggestion(
          image: 'assets/food/thick_yogurt.png',
          name: 'Thick Yogurt',
        ),
        FoodSuggestion(
          image: 'assets/food/thick_porridge.png',
          name: 'Thick Porridge',
        ),
        FoodSuggestion(
          image: 'assets/food/pudding.png',
          name: 'Pudding',
        ),
        FoodSuggestion(
          image: 'assets/food/mousse.png',
          name: 'Mousse',
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
          image: 'assets/food/liquidised_vegetables.png',
          name: 'Liquidised Vegetables',
        ),
        FoodSuggestion(
          image: 'assets/food/smooth_soup.png',
          name: 'Smooth Soup',
        ),
        FoodSuggestion(
          image: 'assets/food/liquidised_fruit.png',
          name: 'Liquidised Fruit',
        ),
        FoodSuggestion(
          image: 'assets/food/smooth_porridge.png',
          name: 'Smooth Porridge',
        ),
        FoodSuggestion(
          image: 'assets/food/liquidised_meat.png',
          name: 'Liquidised Meat',
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
          image: 'assets/food/pureed_vegetables.png',
          name: 'Puréed Vegetables',
        ),
        FoodSuggestion(
          image: 'assets/food/mashed_potato.png',
          name: 'Smooth Mashed Potato',
        ),
        FoodSuggestion(
          image: 'assets/food/pureed_meat.png',
          name: 'Puréed Meat',
        ),
        FoodSuggestion(
          image: 'assets/food/pureed_fruit.png',
          name: 'Puréed Fruit',
        ),
        FoodSuggestion(
          image: 'assets/food/hummus.png',
          name: 'Smooth Hummus',
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
          image: 'assets/food/minced_meat.png',
          name: 'Minced Meat with Gravy',
        ),
        FoodSuggestion(
          image: 'assets/food/cottage_pie.png',
          name: 'Cottage Pie',
        ),
        FoodSuggestion(
          image: 'assets/food/scrambled_eggs.png',
          name: 'Soft Scrambled Eggs',
        ),
        FoodSuggestion(
          image: 'assets/food/moist_casserole.png',
          name: 'Moist Casserole',
        ),
        FoodSuggestion(
          image: 'assets/food/soft_vegetables.png',
          name: 'Soft Cooked Vegetables',
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
          image: 'assets/food/soft_pasta.png',
          name: 'Soft Pasta',
        ),
        FoodSuggestion(
          image: 'assets/food/soft_fish.png',
          name: 'Flaky Fish',
        ),
        FoodSuggestion(
          image: 'assets/food/tender_chicken.png',
          name: 'Tender Chicken',
        ),
        FoodSuggestion(
          image: 'assets/food/soft_bread.png',
          name: 'Soft Bread',
        ),
        FoodSuggestion(
          image: 'assets/food/ripe_banana.png',
          name: 'Ripe Banana',
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
          image: 'assets/food/regular_food.png',
          name: 'Regular Diet',
        ),
        FoodSuggestion(
          image: 'assets/food/steak.png',
          name: 'Steak',
        ),
        FoodSuggestion(
          image: 'assets/food/fresh_salad.png',
          name: 'Fresh Salad',
        ),
        FoodSuggestion(
          image: 'assets/food/crusty_bread.png',
          name: 'Crusty Bread',
        ),
        FoodSuggestion(
          image: 'assets/food/raw_vegetables.png',
          name: 'Raw Vegetables',
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