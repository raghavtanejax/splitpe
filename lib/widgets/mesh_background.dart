import 'package:flutter/material.dart';

class MeshBackground extends StatelessWidget {
  final Widget child;

  const MeshBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F2027), // Deep Space
            Color(0xFF203A43), // Teal Tint
            Color(0xFF2C5364), // Muted Blue
            Color(0xFF7C4DFF), // Electric Purple Accent
            Color(0xFF00E5FF), // Cyan Accent
          ],
          stops: [0.0, 0.3, 0.6, 0.85, 1.0],
        ),
      ),
      child: child,
    );
  }
}
