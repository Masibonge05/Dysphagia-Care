// framework.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FrameworkPage extends StatelessWidget {
  const FrameworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images_sm/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Framework',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 10, // Adjust to align icon visually
                              child: SvgPicture.asset(
                                'assets/icons_sm/arrow1.svg',
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 0),

                Expanded(
                  child: ListView(
                    children: [
                      const Text('Fluids', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _frameworkButton(context, 0, 'Thin', Colors.white, () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LevelDetailPage(level: 'Thin', levelNumber: '0'),
                        ));
                      }),
                      _frameworkButton(context, 1, 'Slightly Thick', const Color(0xFF616566), () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LevelDetailPage(level: 'Slightly Thick', levelNumber: '1'),
                        ));
                      }),
                      _frameworkButton(context, 2, 'Mildly Thick', const Color(0xFFEE60A2), () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LevelDetailPage(level: 'Mildly Thick', levelNumber: '2'),
                        ));
                      }),
                      _frameworkButton(context, 3, 'Moderately Thick', const Color(0xFFE8D900), () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LevelDetailPage(level: 'Moderately Thick', levelNumber: '3'),
                        ));
                      }),
                      _frameworkButton(context, 4, 'Extremely Thick', const Color(0xFF76C04F), () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LevelDetailPage(level: 'Extremely Thick', levelNumber: '4'),
                        ));
                      }),
                      const SizedBox(height: 20),
                      const Text('Food', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _frameworkButton(context, 3, 'Liquidised', const Color(0xFFE8D900), () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LevelDetailPage(level: 'Liquidised', levelNumber: '3'),
                        ));
                      }),
                      _frameworkButton(context, 4, 'Puréed', const Color(0xFF76C04F), () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LevelDetailPage(level: 'Puréed', levelNumber: '4'),
                        ));
                      }),
                      _frameworkButton(context, 5, 'Minced and Moist', const Color(0xFFF0763D), () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LevelDetailPage(level: 'Minced and Moist', levelNumber: '5'),
                        ));
                      }),
                      _frameworkButton(context, 6, 'Soft and Bite-Sized', const Color(0xFF0175BC), () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LevelDetailPage(level: 'Soft and Bite-Sized', levelNumber: '6'),
                        ));
                      }),
                      _frameworkButton(context, 7, 'Regular', const Color(0xFF2E2E31), () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LevelDetailPage(level: 'Regular', levelNumber: '7'),
                        ));
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons_sm/home.svg', height: 24), label: ''),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons_sm/framework_h.svg', height: 30), label: ''),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons_sm/testing.svg', height: 24), label: ''),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons_sm/profile.svg', height: 24), label: ''),
        ],
      ),
    );
  }

  Widget _frameworkButton(BuildContext context, int number, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 382,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF548AD8), Color(0xFF8256D5)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 43,
              height: 43,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(33),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(22),
                ),
              ),
              child: Text(
                '$number',
                style: TextStyle(
                  color: (label == 'Thin' && number == 0) ? const Color(0xFFA6E3D0) : Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Level: $label',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

// MAIN LEVEL PAGE
class LevelDetailPage extends StatelessWidget {
  final String level;
  final String levelNumber;

  const LevelDetailPage({
    super.key,
    required this.level,
    required this.levelNumber,
  });

  // Unique circle color per level
  Color getCircleColor(String levelNumber) {
    switch (levelNumber) {
      case '0':
        return Colors.white;
      case '1':
        return const Color(0xFF616566);
      case '2':
        return const Color(0xFFEE60A2);
      case '3':
        return const Color(0xFFE8D900);
      case '4':
        return const Color(0xFF76C04F);
      case '5':
        return const Color(0xFFF0763D);
      case '6':
        return const Color(0xFF0175BC);
      case '7':
        return const Color(0xFF2E2E31);
      case '9':
        return const Color(0xFF2E2E31);
      default:
        return const Color(0xFFF0763D);
    }
  }

  @override
  Widget build(BuildContext context) {
    final circleColor = getCircleColor(levelNumber);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images_sm/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Level $levelNumber',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  level,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 30),

                // Tiles
                DetailTile(
                  title: 'Characteristics',
                  circleColor: circleColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SectionDetailPage(
                          title: 'Characteristics',
                          levelNumber: levelNumber,
                          levelName: level,
                          circleColor: circleColor,
                        ),
                      ),
                    );
                  },
                ),
                DetailTile(
                  title: 'Physiological Rationale',
                  circleColor: circleColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SectionDetailPage(
                          title: 'Physiological Rationale',
                          levelNumber: levelNumber,
                          levelName: level,
                          circleColor: circleColor,
                        ),
                      ),
                    );
                  },
                ),
                DetailTile(
                  title: 'Recommended Food',
                  circleColor: circleColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SectionDetailPage(
                          title: 'Recommended Food',
                          levelNumber: levelNumber,
                          levelName: level,
                          circleColor: circleColor,
                        ),
                      ),
                    );
                  },
                ),
                DetailTile(
                  title: 'Testing Methods',
                  circleColor: circleColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SectionDetailPage(
                          title: 'Testing Methods',
                          levelNumber: levelNumber,
                          levelName: level,
                          circleColor: circleColor,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TILE THAT NAVIGATES
class DetailTile extends StatelessWidget {
  final String title;
  final Color circleColor;
  final VoidCallback onTap;

  const DetailTile({
    super.key,
    required this.title,
    required this.circleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(33),
            topRight: Radius.circular(33),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(33),
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black12),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}

class SectionDetailPage extends StatelessWidget {
  final String title;
  final String levelNumber;
  final String levelName;
  final Color circleColor;

  const SectionDetailPage({
    super.key,
    required this.title,
    required this.levelNumber,
    required this.levelName,
    required this.circleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images_sm/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Level $levelNumber',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  levelName,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                // Circle + Title
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: circleColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Sample content (you can customize this section)
                const Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    Chip(label: Text("Example tag")),
                    Chip(label: Text("Another item")),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Can be drunk using a teat/nipple, cup, or straw depending on age and ability.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}