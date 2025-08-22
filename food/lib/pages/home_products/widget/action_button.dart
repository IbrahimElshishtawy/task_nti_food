import 'package:flutter/material.dart';

Widget actionButton(IconData icon, String title, VoidCallback onTap) {
  return Column(
    children: [
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(40),
        child: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          child: Icon(icon, color: Colors.redAccent, size: 28),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
