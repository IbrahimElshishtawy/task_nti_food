// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

void showCreditCardDialog(BuildContext context, double totalPrice) {
  String cardNumber = '';
  String expiry = '';
  String cvv = '';

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Credit Card Payment"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Card Number"),
            onChanged: (val) => cardNumber = val,
          ),
          TextField(
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(labelText: "Expiry Date"),
            onChanged: (val) => expiry = val,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "CVV"),
            onChanged: (val) => cvv = val,
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
                  "Your credit card has been charged \$${totalPrice.toStringAsFixed(2)}.\nThank you for your purchase!",
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
