import 'dart:math';
import 'package:flutter/material.dart';

void showWalletDialog(BuildContext context) {
  final TextEditingController cardController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Wallet Payment"),
      content: TextField(
        controller: cardController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: "Enter Wallet / Card Number",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            String transactionId = Random()
                .nextInt(999999)
                .toString()
                .padLeft(6, '0');
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Payment Successful"),
                content: Text(
                  "Payment confirmed!\nTransaction ID: $transactionId",
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
