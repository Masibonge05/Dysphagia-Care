import 'package:flutter/material.dart';

// Imported Pages
import 'level_details.dart';

// Recommended Food Page
class RecommendedFoodPage extends StatelessWidget {
  final int levelNumber;
  final String levelName;
  final Color levelColor;

  const RecommendedFoodPage({super.key, 
    required this.levelNumber,
    required this.levelName,
    required this.levelColor,
  });

  List<String> getRecommendedFood() {
    if (levelNumber == 0) { // Level 0: Thin
      return ['Water',
              'Apple Juice',
              'Cold drink',
              'Full Cream Milk',
              'Coffee','Tea',
              'Fresubin (original)',
              'Fresubin (Protein energy)',
              'Peptamin prebio',
              'Fresubin juice',
              'Supportan',
              'Tropika',
              'Low Fat Milk',
              'Fat Free Milk',
              'Coke Zero',
              ];
            } 
    
    else if (levelNumber == 1) { // Level 1: Slightly Thick
      return ['Sir Juice Mango',
      ];
    } 
    
    else if (levelNumber == 2) {
      return ['Recommended Food for level $levelNumber will be added soon',
      ];
    } 
    
    else if (levelNumber == 3) { // Level 3: Moderately Thick
      return ['Purity (Peach) – 6 months',
              'Clover Custard',
              'Yogi Sip (Danone)',
              'Mageu',
              ];
            } 
    
    else if (levelNumber == 4) {
      return ['Mashed potato',
              'Mashed Banana',
              'Purity (Vegetable and beef) – 7 months]',
              ];
            }
    
    else if (levelNumber == 5) { // Level 5: Minced and Moist
      return ['Mashed Papaya',
              'Mince',
              'Mince (mechanically mashed soft ward diet)',
              ];
            }
    
    else if (levelNumber == 6) { // Level 6: Soft and Bite-Sized
      return ['Soft Vegetables',
              'Samp',
              'Pap',
              'Squash',
              'Shredded chicken',
              'Pumpkin',
              'Instant Oats',
              'Custard Ultra Mel',
              'Weetbix',
              'Fish',
              'Rice',
              'Vegetables',
              'Bread'
              ];
            }
    
    else if (levelNumber == 7) { // Level 7: Regular
      return ['Any Regular Food',
              ];
            }

     else {
      return ['', ''];
    }
  }

  @override
  Widget build(BuildContext context) {
    return InfoPageTemplate(
      levelNumber: levelNumber,
      levelName: levelName,
      levelColor: levelColor,
      title: 'Recommended Food',
      content: getRecommendedFood().map((food) => Text(food)).toList(),
      wrapContentInsteadOfColumn: true,
    );
  }
}
