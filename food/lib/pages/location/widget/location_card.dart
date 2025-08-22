// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 12,
      shadowColor: Colors.black45,
      color: Colors.white.withOpacity(0.95),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Our Restaurant',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.location_on, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '123 Main Street, City, Country',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.access_time, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Open Hours:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              "Mon - Fri: 10:00 AM - 11:00 PM",
              style: TextStyle(fontSize: 14),
            ),
            Text("Sat: 11:00 AM - 12:00 AM", style: TextStyle(fontSize: 14)),
            Text("Sun: 11:00 AM - 10:00 PM", style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
