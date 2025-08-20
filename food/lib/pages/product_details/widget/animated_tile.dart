import 'package:flutter/material.dart';

class AnimatedTile extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const AnimatedTile({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: children,
    );
  }
}
