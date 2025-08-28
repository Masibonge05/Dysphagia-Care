import 'package:flutter/material.dart';

class Welcome1 extends StatelessWidget {
  final VoidCallback onNext;
  
  const Welcome1({
    super.key, 
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: onNext,  // Use callback instead of direct navigation
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            onNext();  // Use callback instead of direct navigation
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Image.asset(
                'assets/images/logo_new.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}