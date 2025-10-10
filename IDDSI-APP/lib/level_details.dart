import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

// Imported Pages
// import 'framework2.dart'; // Assuming Framework2 is not directly used here anymore

// This page is displayed based on the selected option from the testing page pop-up.

class LevelDetailsPage extends StatelessWidget {
  final Map<String, dynamic> arguments;

  const LevelDetailsPage({
    super.key,
    required this.arguments,
  });

  // Helper function to get the content based on the selected option
  List<Widget> _getContent(int levelNumber, String levelType, bool showTesting, bool showTestingMethods, bool showFoodSpecific, bool showCharacteristics, bool showPhysiologicalRationale) {
    if (showTesting) {
      return _getTestingContent(levelNumber, levelType);
    } else if (showTestingMethods) {
      return _getTestingMethods(levelNumber, levelType);
    } else if (showFoodSpecific) {
      return _getFoodSpecificContent(levelNumber, levelType);
    } else if (showCharacteristics) {
       return [
        Text('Characteristics content for Level $levelNumber ($levelType)'),
       ];
    } else if (showPhysiologicalRationale) {
       return [
         Text('Physiological Rationale content for Level $levelNumber ($levelType)'),
       ];
    }
     else {
      return [const Text('No information available for this selection.')]; // Explicitly return a list in the default case
    }
  }

  // Placeholder for Testing content - Will be updated for Level 0 Fluid
  List<Widget> _getTestingContent(int levelNumber, String levelType) {
    // Check for levels 0 to 3 Fluid and Level 3 Food (Liquidised)
    if ((levelNumber >= 0 && levelNumber <= 2 && levelType == 'Fluid') ||
        (levelNumber == 3 && levelType == 'Food')) {
      return [
        // Display the first image (syringe image)
        Image.asset(
          'assets/images/level_0_testing.png', // Path to the syringe image
          fit: BoxFit.contain, // Show the whole image
           // Adjust height or other properties if needed to fit in one frame
        ),
        const SizedBox(height: 16), // Spacing between images
        // Display the second image (screenshot image)
        Image.asset(
          'assets/images/Screenshot 2025-06-03 232729.png', // Path to the screenshot image
           // Adjust height or other properties as needed
        ),
      ];
    } else if (levelNumber == 3 && levelType == 'Fluid') {
       return [
         // Display only the Level 3 Moderately Thick image full screen
         Image.asset(
           'assets/images/testing_for_L3_modarete.png', // Path to the Level 3 Fluid image
           fit: BoxFit.cover, // Make it full screen
         ),
       ];
    } else if (levelNumber == 4 && levelType == 'Food') { // Add case for Level 4
      return [
        // Display the three images for Level 4 Food
        Expanded(
          child: Image.asset(
            'assets/images/sp1.png', // First image for Level 4
            fit: BoxFit.contain, // Adjust fit as needed
          ),
        ),
        const SizedBox(height: 10), // Spacing between images
        Expanded(
          child: Image.asset(
            'assets/images/sp2.png', // Second image for Level 4
            fit: BoxFit.contain, // Adjust fit as needed
          ),
        ),
        const SizedBox(height: 10), // Spacing between images
        Expanded(
          child: Image.asset(
            'assets/images/sp3.png', // Third image for Level 4
            fit: BoxFit.contain, // Adjust fit as needed
          ),
        ),
      ];
    } else if (levelNumber == 5 && levelType == 'Food') { // Add case for Level 5
       return [
        Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
            // First dotted text container
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                 border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 1.0),
              ),
              child: const Text(
                'Use slot between fork prongs (4mm) to\ndetermine whether minced pieces are the\ncorrect or incorrect size',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16), // Spacing
            // Image F1.png
            Image.asset(
              'assets/images/F1.png',
               // Adjust height or other properties as needed
            ),
            const SizedBox(height: 16), // Spacing
            // Second dotted text container (Note)
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                 border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 1.0),
              ),
              child: const Text(
                'Note -( lump size requirements for all\nfoods in Level 5 Minced & Moist:\n➢ Paediatric, equal to or less than\n2mm width and no more than\n8mm in length\n➢ Adult, equal to or less than 4mm\nwidth and no more than 15mm\nin length)',
                 textAlign: TextAlign.left, // Align text to left for list format
              ),
            ),
            const SizedBox(height: 16), // Spacing
            // Image F2.png
            Image.asset(
              'assets/images/F2.png',
               // Adjust height or other properties as needed
            ),
            const SizedBox(height: 16), // Spacing
            // Row of three dotted text containers
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute space evenly
               children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                       border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 1.0),
                    ),
                    child: const Text(
                      'IDDSI Fork Test\nPaediatric, equal to or less than\n2mm width and no more than\n8mm in length\nAdult, equal to or less than\n4mm width and no more than\n15mm in length\n4mm is about the gap between\nthe prongs of a standard dinner\nfork',
                       textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(width: 8), // Spacing between containers
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                       border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 1.0),
                    ),
                    child: const Text(
                      'Soft enough to\nsquash easily with\nfork or spoon\nDon\'t need thumb\nnail to blanch\nwhite',
                       textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(width: 8), // Spacing between containers
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                       border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 1.0),
                    ),
                    child: const Text(
                      'IDDSI Spoon Tilt Test\nSample holds its shape on\nthe spoon and falls off\nfairly easily if the spoon is\ntilted or lightly flicked\nSample should not be firm\nor sticky',
                       textAlign: TextAlign.left,
                    ),
                  ),
                ),
               ],
            ),
           ],
        )
       ];
    } else if (levelNumber == 6 && levelType == 'Food') { // Update case for Level 6 Food
       return [
        const Column(
           crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
           children: [
            Text(
              'Fork Pressure test • Food particles squash easily and change shape when pressure applied with a fork. No hard lumps or pieces\n• When a fork is pressed on the surface of Level 6 Soft & Bite-Sized\nfood, the tines/prongs of a fork make a clear pattern on the surface\nand return to the surface when the fork is removed\n• Bite-sized pieces can be easily separated by pressure from a fork',
               style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 16), // Spacing
            Text(
              'Spoon Tilt test • Food should easily fall or slip off the spoon when tilted and lightly shaken',
               style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 16), // Spacing
            Text(
              'Chopstick test • Chopsticks can be used to eat this texture, but should not be used for testing consistency.',
               style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
           ],
        )
       ];
    } else if (levelNumber == 7 && levelType == 'Food'){
       return [
        const Text('Fork Pressure Test: Bite sized pieces can be easily separated by pressure from a fork.'),
        const Text('Spoon Tilt Test: Food will easily fall off the spoon when tilted and lightly shaken.'),
        const Text('Chopstick Test: Chopsticks can be used to eat this texture, but should not be used for testing consistency.',
        ),
      ];
    }
     else {
      return [
        Text('Testing content for Level $levelNumber ($levelType) - To be implemented.'),
      ];
    }
  }

  // Helper widget for building testing steps
  Widget _buildTestingStep(int stepNumber, String stepText, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
         color: const Color(0xFFE0E0E0), // Adjust background color as needed
         borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.blueAccent, // Adjust color as needed
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                stepNumber.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
                  stepText,
                   style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                ),
                 const SizedBox(height: 8),
                 // Step image
                 Image.asset(
                    imagePath, // Use the passed image path
                    height: 100, // Adjust size as needed
                 ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Integrated Testing Methods content (from original TestingMethodsPage)
  List<Widget> _getTestingMethods(int levelNumber, String levelType) {
    // Helper widget to create the styled text container
    Widget buildStyledTextContainer(String subheading, String content) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Add horizontal padding
            child: Text(
              subheading,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF01224F), // Dark blue color
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFB3E5FC), // Light blue color
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16), // Spacing between blocks
        ],
      );
    }

    if (levelNumber == 0 && levelType == 'Fluid') { // Add case for Level 0 Fluid
      return [
        buildStyledTextContainer(
          'IDDSI Flow Test',
          'IDDSI Flow Test* • Test liquid flows through a 10 mL slip tip syringe#\nleaving 1-4 mL in the\nsyringe after 10 seconds (see IDDSI Flow Test instructions*)',
        ),
      ];
    } else if (levelNumber >= 1 && levelNumber <= 2 && levelType == 'Fluid') { // Add case for Level 1 and 2 Fluid
      return [
        buildStyledTextContainer(
          'IDDSI Flow Test',
          'IDDSI Flow Test* • Test liquid flows through a 10 mL slip tip syringe#\nleaving 1-4 mL in the\nsyringe after 10 seconds (see IDDSI Flow Test instructions*)',
        ),
      ];
    } else if (levelNumber == 3 && (levelType == 'Fluid' || levelType == 'Food')) { // Update case for Level 3 Fluid and Food
      return [
        buildStyledTextContainer(
          'IDDSI Flow Test',
          'IDDSI Flow Test* • Test liquid flows through a 10 ml slip tip syringe leaving > 8 ml in the\nsyringe after 10 seconds (see IDDSI Flow Test Guide*)',
        ),
        buildStyledTextContainer(
          'Fork Drip Test',
          'Fork Drip Test • Drips slowly in dollops through the prongs of a fork\n• When a fork is pressed on the surface of Level 3 Moderately Thick\nLiquid/Liquidised food, the tines/prongs of a fork do not leave a clear\npattern on the surface\n• Spreads out if spilled onto a flat surface',
        ),
        buildStyledTextContainer(
          'Spoon Tilt Test',
          'Spoon Tilt Test • Easily pours from spoon when tilted; does not stick to spoon',
        ),
        buildStyledTextContainer(
          'Where forks are not available\nChopstick Test',
          '• Chopsticks are not suitable for this texture',
        ),
        buildStyledTextContainer(
          'Where forks are not available\nFinger Test',
          '• It is not possible to hold a sample of this food texture using fingers,\nhowever, this texture slides smoothly and easily between the thumb\nand fingers, leaving a coating',
        ),
      ];
    } else if (levelNumber == 4 && levelType == 'Food') { // Update case for Level 4 Food
      return [
        buildStyledTextContainer(
          'IDDSI Flow test',
          'IDDSI Flow test • n/a. The IDDSI Flow test is not applicable, please use the Fork Drip\nTest and Spoon Tilt Test',
        ),
        buildStyledTextContainer(
          'Fork Pressure test',
          'Fork Pressure test • Smooth with no lumps and minimal granulation\n• When a fork is pressed on the surface of Level 4 Extremely Thick\nLiquid/Pureed food, the tines/prongs of a fork can make a clear\npattern on the surface, and/or the food retains the indentation from\nthe fork',
        ),
        buildStyledTextContainer(
          'Fork Drip test',
          'Fork Drip test contd.\n• Sample sits in a mound/pile above the fork; a small amount may flow\nthrough and form a short tail below the fork tines/prongs, but it does\nnot flow or drip continuously through the prongs of a fork (seepicture below)',
        ),
        buildStyledTextContainer(
          'Spoon Tilt test',
          'Spoon Tilt test • Cohesive enough to hold its shape on the spoon\n• A full spoonful must plop off the spoon if the spoon is titled or turned\nsideways; a very gentle flick (using only fingers and wrist) may be\nnecessary to dislodge the sample from the spoon, but the sample\nshould slide off easily with very little food left on the spoon. A thin\nfilm remaining on the spoon after the Spoon Tilt Test is acceptable,\nhowever, you should still be able to see the spoon through the thin\nfilm; i.e. the sample should not be firm and sticky\n• May spread out slightly or slump very slowly on a flat plate',
        ),
        buildStyledTextContainer(
          'Where forks are not available\nChopstick test',
          '• Chopsticks are not suitable for this texture',
        ),
        buildStyledTextContainer(
          'Where forks are not available\nFinger test',
          '• It is just possible to hold a sample of this texture using fingers. The\ntexture slides smoothly and easily between the fingers and leaves\nnoticeable coating',
        ),
        buildStyledTextContainer(
          'Indicators that a sample is too thick',
          '• Does not fall off the spoon when tilted\n• Sticks to spoon',
        ),
      ];
    } else if (levelNumber == 5 && levelType == 'Food') { // Update case for Level 5 Food
      return [
        buildStyledTextContainer(
          'Fork Pressure test',
          'Fork Pressure test • When pressed with a fork the particles should easily be separated\nbetween and come through the tines/prongs of a fork\n• Can be easily mashed with little pressure from a fork [pressure\nshould not make the thumb nail blanch to white]',
        ),
        buildStyledTextContainer(
          'Fork Drip test',
          'Fork Drip test • When a sample is scooped with a fork it sits in a pile or can mound on\nthe fork and does not easily or completely flow or fall through the\ntines/prongs of a fork',
        ),
        buildStyledTextContainer(
          'Spoon Tilt test',
          'Spoon Tilt test • Cohesive enough to hold its shape on the spoon\n• A full spoonful must slide/pour off/fall off the spoon if the spoon is\ntilted or turned sideways or shaken lightly; the sample should slide\noff easily with very little food left on the spoon; i.e. the sample\nshould not be sticky\n• A scooped mound may spread or slump very slightly on a plate',
        ),
        buildStyledTextContainer(
          'Where forks are not available\nChopstick test',
          '• Chopsticks can be used to scoop or hold this texture if the sample is\nmoist and cohesive and the person has very good hand control to use\nchopsticks',
        ),
      ];
    } else if (levelNumber == 6 && levelType == 'Food') { // Update case for Level 6 Food
      return [
        buildStyledTextContainer(
          'Fork Pressure test',
          'Fork Pressure test • Food particles squash easily and change shape when pressure applied with a fork. No hard lumps or pieces\n• When a fork is pressed on the surface of Level 6 Soft & Bite-Sized\nfood, the tines/prongs of a fork make a clear pattern on the surface\nand return to the surface when the fork is removed\n• Bite-sized pieces can be easily separated by pressure from a fork',
        ),
        buildStyledTextContainer(
          'Spoon Tilt test',
          'Spoon Tilt test • Food should easily fall or slip off the spoon when tilted and lightly shaken',
        ),
        buildStyledTextContainer(
          'Chopstick test',
          '• Chopsticks can be used to eat this texture, but should not be used for testing consistency.',
        ),
      ];
    } else if (levelNumber == 7 && levelType == 'Food') { // Update case for Level 7 Food
      return [
        buildStyledTextContainer(
          'Fork Pressure Test',
          'Bite sized pieces can be easily separated by pressure from a fork.',
        ),
        buildStyledTextContainer(
          'Spoon Tilt Test',
          'Food will easily fall off the spoon when tilted and lightly shaken.',
        ),
        buildStyledTextContainer(
          'Chopstick Test',
          'Chopsticks can be used to eat this texture, but should not be used for testing consistency.',
        ),
      ];
    }
    else {
      return [
        Text('Testing Methods content for Level $levelNumber ($levelType): Methods not specifically detailed in provided code.'),
        const Text('Generic method 1: ...'),
        const Text('Generic method 2: ...'),
      ];
    }
  }

  // Placeholder for Food Specific content
  List<Widget> _getFoodSpecificContent(int levelNumber, String levelType) {
    // Match Testing Methods styling (same fonts and background)
    Widget buildStyledTextContainer(String subheading, String content) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              subheading,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF01224F),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFB3E5FC),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      );
    }

    if (levelType == 'Food' && levelNumber == 5) {
      return [
        buildStyledTextContainer('Level 5 – Minced & Moist', 'Food Specific or Other Examples'),
        buildStyledTextContainer('MEAT', '• Finely minced or chopped, soft mince\n• Paediatric: ≤ 2 mm width and ≤ 8 mm length\n• Adult: ≤ 4 mm width and ≤ 15 mm length\n• Serve in mildly, moderately or extremely thick, smooth sauce or gravy; drain excess\n• If texture cannot be finely minced it should be pureed'),
        buildStyledTextContainer('FISH', '• Finely mashed in mildly, moderately or extremely thick smooth sauce or gravy; drain excess\n• Paediatric: ≤ 2 mm width and ≤ 8 mm length\n• Adult: ≤ 4 mm width and ≤ 15 mm length'),
        buildStyledTextContainer('FRUIT', '• Serve finely minced or chopped or mashed\n• Drain excess juice\n• If needed, serve in mildly, moderately or extremely thick smooth sauce or gravy AND drain excess liquid. No thin liquid should separate from food\n• Paediatric: ≤ 2 mm width and ≤ 8 mm length\n• Adult: ≤ 4 mm width and ≤ 15 mm length'),
        buildStyledTextContainer('VEGETABLES', '• Serve finely minced or chopped or mashed\n• Drain any liquid\n• If needed, serve in mildly, moderately or extremely thick smooth sauce or gravy AND drain excess liquid. No thin liquid should separate from food\n• Paediatric: ≤ 2 mm width and ≤ 8 mm length\n• Adult: ≤ 4 mm width and ≤ 15 mm length'),
        buildStyledTextContainer('CEREAL', '• Thick and smooth with small soft lumps\n• Paediatric: ≤ 2 mm width and ≤ 8 mm length\n• Adult: ≤ 4 mm width and ≤ 15 mm length\n• Texture fully softened\n• Any milk/fluid must not separate away from cereal. Drain excess fluid before serving'),
        buildStyledTextContainer('BREAD', '• No regular, dry bread, sandwiches or toast of any kind\n• Use IDDSI Level 5 Minced & Moist sandwich recipe video\nhttps://www.youtube.com/watch?v=W7bOufqmz18\n\n• Pre-gelled “soaked” breads that are very moist and gelled through the entire thickness'),
        buildStyledTextContainer('RICE, COUSCOUS, QUINOA (and similar food textures)', '• Not sticky or glutinous\n• Should not be particulate or separate into individual grains when cooked and served\n• Serve with smooth mildly, moderately or extremely thick sauce AND sauce must not separate away from rice, couscous, quinoa (and similar food textures). Drain excess fluid before serving'),
      ];
    } else if (levelType == 'Food' && levelNumber == 6) {
      return [
        buildStyledTextContainer('Level 6 – Soft & Bite-Sized', 'Food Specific or Other Examples'),
        buildStyledTextContainer('MEAT', '• Cooked, tender meat no bigger than: Paediatric 8 mm pieces; Adults 15 mm (1.5 x 1.5 cm) pieces\n• If texture cannot be served soft and tender at 1.5 cm x 1.5 cm (as confirmed with fork/spoon pressure test), serve minced and moist'),
        buildStyledTextContainer('FISH', '• Soft enough cooked fish to break into small pieces with fork, spoon or chopsticks\n• Paediatric: 8 mm pieces\n• Adults: 15 mm (1.5 cm) pieces\n• No bones or tough skins'),
        buildStyledTextContainer('CASSEROLE / STEW / CURRY', '• Liquid portion (e.g. sauce) must be thick (as per clinician recommendations)\n• Can contain meat, fish or vegetables if final cooked pieces are soft and tender and no larger than: Paediatric 8 mm; Adults 15 mm (1.5 cm)\n• No hard lumps'),
        buildStyledTextContainer('FRUIT', '• Serve minced or mashed if cannot be cut to soft & bite-sized pieces\n• Paediatric: 8 mm pieces\n• Adults: 15 mm (1.5 cm) pieces\n• Fibrous parts of fruit are not suitable\n• Drain excess juice\n• Assess individual ability to manage fruit with high water content (e.g. watermelon) where juice separates from solid in the mouth during chewing'),
        buildStyledTextContainer('VEGETABLES', '• Steamed or boiled vegetables with final cooked size of: Paediatric 8 mm; Adults 15 mm (1.5 cm)\n• Stir fried vegetables may be too firm and are not soft or tender. Check softness with fork/spoon pressure test'),
        buildStyledTextContainer('CEREAL', '• Smooth with soft tender lumps no bigger than: Paediatric 8 mm; Adults 15 mm (1.5 cm)\n• Texture fully softened\n• Any excess milk or liquid must be drained and/or thickened to thickness level recommended by clinician'),
        buildStyledTextContainer('BREAD', '• No regular dry bread, sandwiches or toast of any kind\n• Use IDDSI Level 5 Minced & Moist sandwich recipe video to prepare bread and add to filling that meets Level 6 Soft & Bite-Sized requirements\nhttps://www.youtube.com/watch?v=W7bOufqmz18\n\n• Pre-gelled “soaked” breads that are very moist and gelled through the entire thickness'),
        buildStyledTextContainer('RICE, COUSCOUS, QUINOA (and similar food textures)', '• Not particulate/grainy, sticky or glutinous'),
      ];
    } else if (levelType == 'Food' && levelNumber == 7) {
      return [
        buildStyledTextContainer('Level 7 – Easy to Chew', 'Food Specific or Other Examples'),
        buildStyledTextContainer('MEAT', '• Cooked until tender\n• If texture cannot be served soft and tender, serve minced and moist'),
        buildStyledTextContainer('FISH', '• Soft enough cooked fish to break into small pieces with the side of a fork, spoon or chopsticks'),
        buildStyledTextContainer('CASSEROLE / STEW / CURRY', '• Can contain meat, fish, vegetables, or combinations of these if final cooked pieces are soft and tender\n• Serve in mildly, moderately or extremely thick sauce AND drain excess liquid\n• No hard lumps'),
        buildStyledTextContainer('FRUIT', '• Soft enough to be cut or broken apart into smaller pieces with the side of a fork or spoon\n• Do not use the fibrous parts of fruit (e.g. the white part of an orange)'),
        buildStyledTextContainer('VEGETABLES', '• Steam or boil vegetables until tender\n• Stir fried vegetables may be too firm for this level. Check softness with fork/spoon pressure test'),
        buildStyledTextContainer('CEREAL', '• Served with texture softened\n• Drain excess milk or liquid and/or thicken to thickness level recommended by clinician'),
        buildStyledTextContainer('BREAD', '• Bread, sandwiches and toast that can be cut or broken apart into smaller pieces with the side of a fork or spoon can be provided at clinician discretion'),
        buildStyledTextContainer('RICE, COUSCOUS, QUINOA (and similar food textures)', '• No special instructions'),
      ];
    }

    return [Text('Food Specific content for Level $levelNumber ($levelType) is not available.')];
  }
   // Helper function to get level color (from original TestingPage2)
   Color _getLevelColor(int levelNumber, String levelType) {
    if (levelType == 'Fluid') {
      switch (levelNumber) {
        case 0:
          return const Color(0xFFA6E3D0);
        case 1:
          return const Color(0xFF616566);
        case 2:
          return const Color(0xFFEE60A2);
        case 3:
          return const Color(0xFFE8D900);
        case 4:
          return const Color(0xFF76C04F);
        default:
          return Colors.blue;
      }
    } else if (levelType == 'Food') {
       switch (levelNumber) {
        case 3:
          return const Color(0xFFE8D900);
        case 4:
          return const Color(0xFF76C04F);
        case 5:
          return const Color(0xFFF0763D);
        case 6:
          return const Color(0xFF0175BC);
        case 7:
          return const Color(0xFF2E2E31);
        default:
          return Colors.orange;
       }
    }
    return Colors.grey;
  }

  // Helper function to get text color (from original TestingPage2)
    Color _getTextColor(int levelNumber, String levelType) {
     if (levelNumber == 0 && levelType == 'Fluid') {
      return Colors.black87;
    } else {
      return Colors.white;
    }
  }


  @override
  Widget build(BuildContext context) {
    final int levelNumber = arguments['levelNumber'];
    final String levelType = arguments['levelType'];
    final String pageTitle = arguments['pageTitle'] ?? 'Level Details'; // Provide a default value if pageTitle is null
    final bool showTesting = arguments['showTesting'] ?? false;
    final bool showTestingMethods = arguments['showTestingMethods'] ?? false;
    final bool showFoodSpecific = arguments['showFoodSpecific'] ?? false;
    // Add arguments for Characteristics and Physiological Rationale
    final bool showCharacteristics = arguments['showCharacteristics'] ?? false;
    final bool showPhysiologicalRationale = arguments['showPhysiologicalRationale'] ?? false;


    // Determine the title for the InfoPageTemplate based on which option was selected
    String infoTitle = '';
    if (showTesting) {
      infoTitle = 'Testing';
    } else if (showTestingMethods) {
      infoTitle = 'Testing Methods';
    } else if (showFoodSpecific) {
      infoTitle = 'Food Specific';
    } else if (showCharacteristics) {
       infoTitle = 'Characteristics';
    } else if (showPhysiologicalRationale) {
       infoTitle = 'Physiological Rationale';
    }
     else {
        infoTitle = pageTitle; // Use the provided page title if no specific section is selected
     }


    // Get the content based on the selected option
    final List<Widget> content = _getContent(
        levelNumber,
        levelType,
        showTesting,
        showTestingMethods,
        showFoodSpecific,
        showCharacteristics,
        showPhysiologicalRationale
);

     final Color levelColor = _getLevelColor(levelNumber, levelType);

    return InfoPageTemplate(
      levelNumber: levelNumber,
      levelName: levelType, // Pass the type as levelName for now, adjust if needed
      levelColor: levelColor,
      title: infoTitle,
      content: content,
      // You might need to add logic here to decide if content should be wrapped
      // based on the type of information being displayed.
      // For now, defaulting to false (Column layout).
      wrapContentInsteadOfColumn: false,
    );
  }
}

// INFO PAGE TEMPLATE (Assuming this is in the same file)
class InfoPageTemplate extends StatelessWidget {
  final int levelNumber;
  final String levelName;
  final Color levelColor;
  final String title;
  final List<Widget> content; // Changed to List<Widget>
  final bool wrapContentInsteadOfColumn;

  const InfoPageTemplate({super.key, 
    required this.levelNumber,
    required this.levelName,
    required this.levelColor,
    required this.title,
    required this.content,
    this.wrapContentInsteadOfColumn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomGradientAppBar(
        levelText: 'Level ${levelNumber.toString()}',
        titleText: '$levelName $title', // Combined title in AppBar
        onBack: () => Navigator.of(context).pop(),
        ),
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     // Keep the title row if needed, adjust padding as necessary
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add padding back to the title row
                       child: Row(
                         children: [
                           Container(
                             width: 40,
                             height: 40,
                             decoration: BoxDecoration(
                               color: levelColor,
                               shape: BoxShape.circle,
                               border: Border.all(color: Colors.black, width: 0.8),
                             ),
                           ),
                           const SizedBox(width: 8),
                           Expanded( // Use Expanded to prevent overflow
                             child: Text(
                               title, // Use the 'title' parameter
                               style: const TextStyle(
                                 fontWeight: FontWeight.w800,
                                 fontSize: 18,
                                 fontFamily: 'Poppins',
                                 color: Color(0xFF01224F),
                               ),
                                overflow: TextOverflow.ellipsis,
                             ),
                           ),
                         ],
                       ),
                     ),
                    
                    // Render the list of widgets directly - these will now extend to edges if they are the primary content
                    ...content.where((widget) => widget != null),

                  ],
                ),
              ),
            )
          );
        },
      ),
    ]),
  );
}
}

// Assuming CustomGradientAppBar is defined in this file or imported.
// If it's not, you'll need to provide its code or import it.
// For now, adding a placeholder definition.

class CustomGradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final String levelText;
  final VoidCallback onBack;

  const CustomGradientAppBar({super.key, 
    required this.titleText,
    required this.levelText,
    required this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF44157F), Color(0xFF7A60D6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: onBack,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    levelText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    titleText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 40), // Placeholder for spacing
            ],
          ),
        ),
      ),
    );
  }
}

// Remove or comment out the old classes if they are no longer needed
// class CharacteristicsPage extends StatelessWidget { ... }
// class PhysiologicalRationalePage extends StatelessWidget { ... }
// class TestingMethodsPage extends StatelessWidget { ... }
// class InfoPageTemplate extends StatelessWidget { ... } // If moved or integrated