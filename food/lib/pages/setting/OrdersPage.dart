import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // بيانات وهمية للطلبات والحجوزات (يمكن ربطها بقاعدة بيانات Firebase)
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
    {
      "id": "#003",
      "date": "2025-08-15",
      "total": 32.00,
      "items": [
        {"name": "Sushi", "quantity": 4, "price": 8.0},
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
      appBar: AppBar(
        title: const Text("Order History"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
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
        },
      ),
    );
  }
}
