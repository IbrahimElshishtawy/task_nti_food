import 'package:flutter/material.dart';

Widget bannerItem(String imagePath) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(imagePath, fit: BoxFit.cover),
    ),
  );
}
