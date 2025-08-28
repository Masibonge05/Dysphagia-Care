import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Imported Pages
import 'framework2.dart';

// This page is displayed when a user taps on either the
// "Characteristics", "Physiological Rationale", "Recommended Food", or "Testing Methods" buttons

// CHARACTERISTICS PAGE
class CharacteristicsPage extends StatelessWidget {
  final int levelNumber;
  final String levelName;
  final Color levelColor;

  const CharacteristicsPage({super.key, 
    required this.levelNumber,
    required this.levelName,
    required this.levelColor,
  });

  List<String> getCharacteristics() {
    switch (levelNumber) {
      case 0:
        return [
          'Flows like water ',
          'Fast flow ',
          'Can drink through any type of teat/nipple, cup or straw as appropriate for age and skills ',
        ];

      case 1:
        return [
          'Thicker than water ',
          'Requires a little more effort to drink than thin liquids ',
          'Flows through a straw, syringe, teat/nipple ',
          'Similar to the thickness of most commercially available Anti-regurgitation (AR) infant formulas ',
        ];

      case 2:
        return [
          'Flows off a spoon ',
          'Sippable, pours quickly from a spoon, but slower than thin drinks',
          'Mild effort is required to drink this thickness through standard bore straw (standard bore straw = 0.209 inch or 5.3 mm diameter) ',
        ];

      case 3:
        return [
          'Can be drunk from a cup',
          'Can be eaten with a spoon',
          'Moderate effort required to suck through standard bore or wide bore straw (wide bore straw = 0.275 inch or 6.9 mm)',
          'Cannot be piped, layered or molded on a plate because it will not retain its shape',
          'Cannot be eaten with a fork because it drips slowly in dollops through the prongs',
          'No oral processing or chewing required – can be swallowed directly',
          'Smooth texture with no bits (lumps, fibers, bits of shell or skin, husk, particles of gristle or bone)',
        ];

      case 4:
        return [
          'Usually eaten with a spoon (a fork is possible)',
          'Cannot be drunk from a cup because it does not flow easily',
          'Cannot be sucked through a straw',
          'Does not require chewing',
          'Can be piped, layered or molded because it retains its shape, but should not require chewing if presented in this form',
          'Shows some very slow movement under gravity but cannot be poured ',
          'Falls off spoon in a single spoonful when tilted and continues to hold shape on a plate',
          'No lumps',
          'Not sticky',
          'Liquid must not separate from solid',
        ];

      case 5:
        return [
          'Can be eaten with a fork or spoon',
          'Could be eaten with chopsticks in some cases, if the individual has very good hand control',
          'Can be scooped and shaped (e.g. into a ball shape) on a plate',
          'Soft and moist with no separate thin liquid',
          'Small lumps visible within the food\nPaediatric, equal to or less than 2 mm width and no longer than 8mm in length\nAdult, equal to or less than 4mm width and no longer than 15mm in length',
          'Lumps are easy to squash with tongue ',
        ];

      case 6:
        return [
          'Can be eaten with a fork, spoon or chopsticks',
          'Can be mashed/broken down with pressure from fork, spoon or chopsticks',
          'A knife is not required to cut this food, but may be used to help load a fork or spoon',
          'Soft, tender and moist throughout but with no separate thin liquid',
          'Chewing is required before swallowing',
          'Bite-sized' 
          'pieces as appropriate for size and oral processing skills\nPaediatric, 8mm pieces (no larger than)\nAdults, 15 mm = 1.5 cm pieces (no larger than) ',
        ];

      case 7:
        return [
          'Normal, everyday foods of soft/tender textures that are developmentally and age appropriate ',
          'Any method may be used to eat these foods',
          'Sample size is not restricted at Level 7, therefore, foods may be of a range of sizes\nSmaller or greater than 8mm pieces (Paediatric)\nSmaller or greater than 15 mm = 1.5 cm pieces (Adults) ',
          'Does not include: hard, tough, chewy, fibrous, stringy, crunchy, or crumbly bits, pips, seeds, fibrous parts of fruit, husks or bones',
          'May include dual consistency or mixed consistency foods and liquids if also safe for Level 0, and at clinician discretion. If unsafe for Level 0\nThin, liquid portion can be thickened to clinicians recommended thickness level',
        ];

      default:
        return [
          '',
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return InfoPageTemplate(
      levelNumber: levelNumber,
      levelName: levelName,
      levelColor: levelColor,
      title: 'Characteristics',
      content: getCharacteristics(),
    );
  }
}

// Physiological Rationale Page
class PhysiologicalRationalePage extends StatelessWidget {
  final int levelNumber;
  final String levelName;
  final Color levelColor;

  const PhysiologicalRationalePage({super.key, 
    required this.levelNumber,
    required this.levelName,
    required this.levelColor,
  });

  List<String> getRationale() {
    if (levelNumber == 0) {
      return [
        'Functional ability to safely manage liquids of all types',
      ];
    } else if (levelNumber == 1) {
      return [
        'Often used in the paediatric population as a thickened drink that reduces speed of flow yet is still able to flow through an infant teat/nipple. Consideration to flow through a teat/nipple should be determined on a case-by-case basis.',
        'Also used in adult populations where thin drinks flow too fast to be controlled safely. These slightly thick liquids will flow at a slightly slower rate',
      ];
    } else if (levelNumber == 2) {
      return [
        'If thin drinks flow too fast to be controlled safely, these Mildly Thick liquids will flow at a slightly slower rate ',
        'May be suitable if tongue control is slightly reduced.',
      ];
    } else if (levelNumber == 3) {
      return [
        'If tongue control is insufficient to manage Mildly Thick drinks (Level 2), this Liquidised/Moderately thick level may be suitable  ',
        'Allows more time for oral control',
        'Needs some tongue propulsion effort',
        'Pain on swallowing',
      ];
    } else if (levelNumber == 4) {
      return [
        'If tongue control is significantly reduced, this category may be easiest to control',
        'Requires less propulsion effort than Minced & Moist (level 5), Soft & Bite-Sized (Level 6) and Regular and Regular Easy to Chew (Level 7) but more than Liquidised/Moderately thick (Level 3)',
        'No biting or chewing is required',
        'Increased oral and/or pharyngeal residue is a risk if too sticky',
        'Any food that requires chewing, controlled manipulation or bolus formation are not suitable ',
        'Pain on chewing or swallowing',
        'Missing teeth, poorly fitting dentures',
      ];
    } else if (levelNumber == 5) {
      return [
        'Biting is not required',
        'Minimal chewing is required ',
        'Tongue force alone can be used to separate the soft small particles in this texture ',
        'Tongue force is required to move the bolus',
        'Pain or fatigue on chewing  ',
        'Missing teeth, poorly fitting dentures',
      ];
    } else if (levelNumber == 6) {
      return [
        'Biting is not required',
        'Chewing is required',
        'Food piece sizes designed to minimize choking risk',
        'Tongue force and control is required to move the food and keep it within the mouth for chewing and oral processing ',
        'Tongue force is required to move the bolus for swallowing',
        'Pain or fatigue on chewing',
        'Missing teeth, poorly fitting dentures',
      ];
    } else if (levelNumber == 7) {
      return [
        'Easy to Chew:\n'
            'Requires the ability to bite soft foods and chew and orally process food for long enough that the person forms a soft cohesive ball/bolus that is swallow ready.  Does not necessarily require teeth.  ',
        'Requires the ability to chew and orally process soft/tender foods without tiring easily ',
        'May be suitable for people who find hard and/or chewy foods difficult or painful to chew and swallow ',
        'This level could present a choking risk for people with clinically identified increased risk of choking, because food pieces can be of any size. Restricting food piece sizes aims to minimize choking risk (e.g. Level 4 Pureed, Level 5 Minced & Moist, Level 6 Soft & Bite-sized have food piece size restrictions to minimize choking risk)  ',
        'This level may be used by qualified clinicians for developmental teaching, or progression to foods that need more advanced chewing skills',
        'If the person needs supervision to eat safely, before using this texture level consult a qualified clinician to determine the persons food texture needs, and meal time plan for safety \n• People can be unsafe to eat without supervision due to chewing and swallowing problems and/or unsafe mealtime behaviours.  Examples of unsafe mealtime behaviors include: not chewing very well, putting too much food into the mouth, eating too fast or swallowing large mouthfuls of food, inability to self-monitor chewing ability.\n• Clinicians should be consulted for specific advice for patient needs, requests and requirements for supervision.n/• Where mealtime supervision is needed, this level should only be used under the strict recommendation and written guidance of a qualified clinician ',
        'Regular:\n'
            'Ability to bite hard or soft foods and chew them for long enough that they form a soft cohesive ball/bolus that is swallow ready ',
        'An ability to chew all food textures without tiring easily',
        'An ability to remove bone or gristle that cannot be swallowed safely from the mouth',
      ];
    } else {
      return [
        '',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return InfoPageTemplate(
      levelNumber: levelNumber,
      levelName: levelName,
      levelColor: levelColor,
      title: 'Physiological Rationale',
      content: getRationale(),
    );
  }
}

// Testing Methods Page
class TestingMethodsPage extends StatelessWidget {
  final int levelNumber;
  final String levelName;
  final Color levelColor;

  const TestingMethodsPage({super.key, 
    required this.levelNumber,
    required this.levelName,
    required this.levelColor,
  });

  List<String> getMethods() {
    if (levelNumber == 3) {
      return [
        'IDDSI Flow Test:\nTest liquid flows through 10 ml slip tip syringe leaving > 8 ml in the syringe after 10 seconds',
        'Fork Drip Test:\nDrips slowly in dollops through the prongs of a fork',
        'When a fork is pressed on the surface of Level 3 Moderately Thick Liquid/Liquidised food, the tines/prongs of a fork do not leave a clear pattern on the surface',
        'Spreads out if spilled onto a flat surface',
        'Spoon Tilt Test:\nEasily pours from spoon when tilted; does not stick to spoon',
        'Chopstick Test:\nChopsticks are not suitable for this texture',
      ];
    } else if (levelNumber == 0) {
      return [
        'IDDSI Flow Test:\n• Test liquid flows through a 10 mL slip tip syringe#\nleaving 1-4 mL in the\nsyringe after 10 seconds (see IDDSI Flow Test instructions*)',
      ];
    } else if (levelNumber == 1) {
      return [
        'IDDSI Flow Test:\n • Test liquid flows through a 10 mL slip tip syringe#\nleaving 1-4 mL in the\nsyringe after 10 seconds (see IDDSI Flow Test instructions*)',
      ];
    } else if (levelNumber == 2) {
      return [
        'IDDSI Flow Test:\n • Test liquid flows through a 10 mL slip tip syringe#\nleaving 1-4 mL in the\nsyringe after 10 seconds (see IDDSI Flow Test instructions*)',
      ];
    } else if (levelNumber == 4) {
      return [
        'Fork Pressure test:\n• Smooth with no lumps and minimal granulation\n• When a fork is pressed on the surface of Level 4 Extremely Thick\nLiquid/Pureed food, the tines/prongs of a fork can make a clear\npattern on the surface, and/or the food retains the indentation from\nthe fork',
        'Fork Drip test:\n• Sample sits in a mound/pile above the fork; a small amount may flow\nthrough and form a short tail below the fork tines/prongs, but it does\nnot flow or drip continuously through the prongs of a fork (seepicture below)',
        'Spoon Tilt test:\nCohesive enough to hold its shape on the spoon\n• A full spoonful must plop off the spoon if the spoon is titled or turned\nsideways; a very gentle flick (using only fingers and wrist) may be\nnecessary to dislodge the sample from the spoon, but the sample\nshould slide off easily with very little food left on the spoon. A thin\nfilm remaining on the spoon after the Spoon Tilt Test is acceptable,\nhowever, you should still be able to see the spoon through the thin\nfilm; i.e. the sample should not be firm and sticky\n• May spread out slightly or slump very slowly on a flat plate',
        'Chopstick test:\nWhere forks are not available.\n• Chopsticks are not suitable for this texture',
      ];
    } else if (levelNumber == 5) {
      return [
        'Fork Pressure test:\n• When pressed with a fork the particles should easily be separated\nbetween and come through the tines/prongs of a fork\n• Can be easily mashed with little pressure from a fork [pressure\nshould not make the thumb nail blanch to white]',
        'Fork Drip test:\n• When a sample is scooped with a fork it sits in a pile or can mound on\nthe fork and does not easily or completely flow or fall through the\ntines/prongs of a fork',
        'Spoon Tilt test:\n• Cohesive enough to hold its shape on the spoon\n• A full spoonful must slide/pour off/fall off the spoon if the spoon is\ntilted or turned sideways or shaken lightly; the sample should slide\noff easily with very little food left on the spoon; i.e. the sample\nshould not be sticky\n• A scooped mound may spread or slump very slightly on a plate',
        'Chopstick test:\n• Chopsticks can be used to scoop or hold this texture if the sample is\nmoist and cohesive and the person has very good hand control to use\nchopsticks',
      ];
    } else if (levelNumber == 6) {
      return [
        'Fork Pressure test:\n • Food particles squash easily and change shape when pressure applied with a fork. No hard lumps or pieces\n• When a fork is pressed on the surface of Level 6 Soft & Bite-Sized\nfood, the tines/prongs of a fork make a clear pattern on the surface\nand return to the surface when the fork is removed\n• Bite-sized pieces can be easily separated by pressure from a fork',
        'Spoon Tilt test:\n • Food should easily fall or slip off the spoon when tilted and lightly shaken',
        'Chopstick test:\n • Chopsticks can be used to eat this texture, but should not be used for testing consistency.',
      ];
    } else if (levelNumber == 7) {
      return [
        'Fork Pressure Test:\n • Bite sized pieces can be easily separated by pressure from a fork.',
        'Spoon Tilt Test: \n • Food will easily fall off the spoon when tilted and lightly shaken.',
        'Chopstick Test:\n • Chopsticks can be used to eat this texture, but should not be used for testing consistency.',
      ];
    } else {
      return [
        '',
        '',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return InfoPageTemplate(
      levelNumber: levelNumber,
      levelName: levelName,
      levelColor: levelColor,
      title: 'Testing Methods',
      content: getMethods(),
    );
  }
}

// INFO PAGE TEMPLATE
class InfoPageTemplate extends StatelessWidget {
  final int levelNumber;
  final String levelName;
  final Color levelColor;
  final String title;
  final List<String> content;
  final bool wrapContentInsteadOfColumn;

  const InfoPageTemplate({super.key, 
    required this.levelNumber,
    required this.levelName,
    required this.levelColor,
    required this.title,
    required this.content,
    this.wrapContentInsteadOfColumn = false,
  });

  // Navigation methods
  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _navigateToFramework(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/framework', (route) => false);
  }

  void _navigateToFoodTesting(BuildContext context) {
    Navigator.pushNamed(context, '/testing');
  }

  void _navigateToChatbot(BuildContext context) {
    Navigator.pushNamed(context, '/chatbot');
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomGradientAppBar(
        levelText: levelName,
        titleText: 'Level ${levelNumber.toString()}',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: levelColor,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black, width: 0.8),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                color: Color(0xFF01224F),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        wrapContentInsteadOfColumn
                            ? Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: content
                                    .map(
                                      (item) => Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF98DAF8),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF01224F),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: content
                                    .map(
                                      (item) => Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(bottom: 12),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF98DAF8),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF01224F),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                        const SizedBox(height: 100), // Space for bottom nav
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context: context,
                  iconPath: 'assets/icons/home.svg',
                  isSelected: false,
                  label: 'Home',
                  onTap: () => _navigateToHome(context),
                ),
                _buildNavItem(
                  context: context,
                  iconPath: 'assets/icons/framework.svg',
                  isSelected: true, // Framework is selected (these pages are part of framework)
                  label: 'Records',
                  onTap: () => _navigateToFramework(context),
                ),
                _buildNavItem(
                  context: context,
                  iconPath: 'assets/icons/testing.svg',
                  isSelected: false,
                  label: 'Test',
                  onTap: () => _navigateToFoodTesting(context),
                ),
                _buildNavItem(
                  context: context,
                  iconPath: 'assets/icons/profile.svg',
                  isSelected: false,
                  label: 'Chat',
                  onTap: () => _navigateToChatbot(context),
                ),
                _buildNavItem(
                  context: context,
                  iconPath: 'assets/icons/Account.svg',
                  isSelected: false,
                  label: 'Profile',
                  onTap: () => _navigateToProfile(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required String iconPath,
    required bool isSelected,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF44157F).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            iconPath,
            color: isSelected ? const Color(0xFF44157F) : Colors.grey,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
