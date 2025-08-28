import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class EmojiAnimationSelector extends StatefulWidget {
  const EmojiAnimationSelector({super.key});

  @override
  State<EmojiAnimationSelector> createState() => _EmojiAnimationSelectorState();
}

class _EmojiAnimationSelectorState extends State<EmojiAnimationSelector> with TickerProviderStateMixin {
  final Map<String, String> moodFiles = {
    "angry": "assets/animations/angry.json",
    "sad": "assets/animations/sad.json",
    "neutral": "assets/animations/neutral.json",
    "happy": "assets/animations/happy.json",
    "superMood": "assets/animations/superMood.json",
  };

  String? selectedMood;
  final Map<String, AnimationController> controllers = {};

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onMoodTap(String mood) {
    setState(() {
      if (selectedMood == mood) {
        // Reset the same mood to start without animation
        controllers[mood]?.stop();
        controllers[mood]?.value = 0.0;
        selectedMood = null;
      } else {
        // Reset previous mood instantly
        if (selectedMood != null) {
          controllers[selectedMood!]?.stop();
          controllers[selectedMood!]?.value = 0.0;
        }

        // Animate new mood
        selectedMood = mood;
        controllers[mood]?.forward(from: 0.0);
      }
    });
  }

  Widget _buildEmoji(String mood) {
    controllers[mood] ??= AnimationController(vsync: this);

    return Lottie.asset(
      moodFiles[mood]!,
      controller: controllers[mood],
      onLoaded: (composition) {
        final controller = controllers[mood]!;
        controller.duration = composition.duration;

        if (selectedMood == mood) {
          controller.value = 1.0;
        } else {
          controller.value = 0.0;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: moodFiles.keys.map((mood) {
        return GestureDetector(
          onTap: () => _onMoodTap(mood),
          child: SizedBox(
            width: 64,
            height: 64,
            child: _buildEmoji(mood),
          ),
        );
      }).toList(),
    );
  }
}
