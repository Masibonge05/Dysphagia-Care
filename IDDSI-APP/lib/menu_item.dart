import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String svgPath;
  final String arrowPath;
  final VoidCallback? onTap;
  final bool isSelected; // Added isSelected property

  const MenuItem({
    super.key,
    required this.title,
    required this.svgPath,
    required this.arrowPath,
    this.onTap,
    this.isSelected = false, // Default to false
  });

  @override         
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.transparent, // Highlight selection
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                svgPath,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF1F41BB),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.blue.shade900 : Colors.black, // Change text color when selected
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 16,
              height: 16,
              child: SvgPicture.asset(
                arrowPath,
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.blue.shade900 : const Color(0xFF1F41BB),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
