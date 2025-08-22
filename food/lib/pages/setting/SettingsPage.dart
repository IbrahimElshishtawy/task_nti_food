import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double appRating = 0.0; // تقييم البرنامج

  // بيانات وهمية للطلبات (يمكن ربطها بقاعدة بيانات حقيقية لاحقًا)
  final List<Map<String, dynamic>> orders = [
    {
      "id": "#001",
      "date": "2025-08-20",
      "total": 24.99,
      "items": [
        {"name": "Pizza", "quantity": 2, "price": 12.5},
      ],
    },
    {
      "id": "#002",
      "date": "2025-08-18",
      "total": 15.50,
      "items": [
        {"name": "Burger", "quantity": 1, "price": 7.5},
        {"name": "Soda", "quantity": 1, "price": 8.0},
      ],
    },
  ];

  void showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Order ${order['id']} Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Date: ${order['date']}"),
            const SizedBox(height: 10),
            ...List.generate(order['items'].length, (index) {
              final item = order['items'][index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(item['name']),
                subtitle: Text("Quantity: ${item['quantity']}"),
                trailing: Text(
                  "\$${(item['price'] * item['quantity']).toStringAsFixed(2)}",
                ),
              );
            }),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total: \$${order['total'].toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 12),
          // خيار اللغة
          ListTile(
            leading: const Icon(Icons.language, color: Colors.deepOrangeAccent),
            title: const Text("Language"),
            subtitle: const Text("Select your preferred language"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // منطق اختيار اللغة
            },
          ),
          const Divider(),
          // خيار الإشعارات
          ListTile(
            leading: const Icon(
              Icons.notifications,
              color: Colors.deepOrangeAccent,
            ),
            title: const Text("Notifications"),
            subtitle: const Text("Enable or disable notifications"),
            trailing: Switch(
              value: true,
              activeColor: Colors.deepOrangeAccent,
              onChanged: (val) {
                // منطق تفعيل/تعطيل الإشعارات
              },
            ),
          ),
          const Divider(),
          // خيار حول التطبيق
          ListTile(
            leading: const Icon(Icons.info, color: Colors.deepOrangeAccent),
            title: const Text("About App"),
            subtitle: const Text("Version 1.0.0"),
            onTap: () {
              // منطق عرض معلومات التطبيق
            },
          ),
          const Divider(),
          const SizedBox(height: 24),
          // جزء تقييم التطبيق
          const Text(
            "Rate Our App",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          RatingBar.builder(
            initialRating: appRating,
            minRating: 1,
            maxRating: 5,
            allowHalfRating: true,
            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.orange),
            onRatingUpdate: (rating) {
              setState(() {
                appRating = rating;
              });
              // إرسال التقييم إلى السيرفر أو Firebase
            },
          ),
          const SizedBox(height: 16),
          Text(
            "Your rating: ${appRating.toStringAsFixed(1)} stars",
            style: const TextStyle(fontSize: 16),
          ),
          const Divider(),
          const SizedBox(height: 24),
          // قسم الطلبات السابقة
          const Text(
            "Order History",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...orders.map((order) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: const Icon(
                  Icons.receipt_long,
                  color: Colors.deepOrangeAccent,
                ),
                title: Text("Order ${order['id']}"),
                subtitle: Text("Date: ${order['date']}"),
                trailing: Text("\$${order['total'].toStringAsFixed(2)}"),
                onTap: () => showOrderDetails(order),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
