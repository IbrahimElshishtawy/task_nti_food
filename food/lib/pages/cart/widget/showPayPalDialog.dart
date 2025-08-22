// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

void showPayPalDialog(BuildContext context, double totalPrice) {
  String email = '';
  String password = '';

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("PayPal Payment"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: "Email"),
            onChanged: (val) => email = val,
          ),
          TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Password"),
            onChanged: (val) => password = val,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Order Placed"),
                content: Text(
                  "You have successfully paid \$${totalPrice.toStringAsFixed(2)} via PayPal.",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          },
          child: const Text("Pay"),
        ),
      ],
    ),
  );
}
