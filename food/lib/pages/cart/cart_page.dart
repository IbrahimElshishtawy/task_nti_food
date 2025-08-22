import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/cart/widget/PaymentSect.dart';
import 'package:food/pages/cart/widget/TotalSection.dart';
import 'package:food/pages/cart/widget/cart_item.dart';
import 'package:food/pages/cart/widget/cart_item_card.dart';
import 'package:food/pages/cart/widget/showPayPalDialog.dart';
import 'package:food/pages/cart/widget/wallet_dialog.dart';

class CartPage extends StatefulWidget {
  final List<ApiModel> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<ApiModel> cart;
  String paymentMethod = "Cash";

  @override
  void initState() {
    super.initState();
    cart = List.from(widget.cartItems);
  }

  void increaseQuantity(int index) => setState(() => cart[index].quantity++);
  void decreaseQuantity(int index) {
    setState(() {
      cart[index].quantity--;
      if (cart[index].quantity <= 0) cart.removeAt(index);
    });
  }

  double get totalPrice =>
      cart.fold(0, (sum, item) => sum + item.price * item.quantity);

  void selectPayment(String method) {
    setState(() => paymentMethod = method);
    if (method == "Wallet") showWalletDialog(context);
  }

  String getPaymentMessage() {
    switch (paymentMethod) {
      case "Cash":
        return "You have chosen Cash on Delivery.\nPlease have \$${totalPrice.toStringAsFixed(2)} ready when your order arrives.";
      case "Credit Card":
        return "Your credit card will be charged \$${totalPrice.toStringAsFixed(2)}.";
      case "PayPal":
        return "You will pay \$${totalPrice.toStringAsFixed(2)} via PayPal.";
      case "Wallet":
        return "You have successfully paid \$${totalPrice.toStringAsFixed(2)} using your Wallet.";
      default:
        return "Payment info not available.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: cart.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cart.length,
                    itemBuilder: (context, index) => CartItemCard(
                      item: cart[index],
                      onIncrease: () => increaseQuantity(index),
                      onDecrease: () => decreaseQuantity(index),
                    ),
                  ),
                ),
                PaymentSection(
                  paymentMethod: paymentMethod,
                  onSelect: selectPayment,
                ),
                TotalSection(
                  totalPrice: totalPrice,
                  paymentMethod: paymentMethod,
                  onCreditCard: () => showCreditCardDialog(context, totalPrice),
                  onPayPal: () => showPayPalDialog(context, totalPrice),
                  onWallet: () => shdowWalletDialog(context),
                  onCash: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Order Placed"),
                      content: Text(getPaymentMessage()),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void shdowWalletDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Order Placed"),
        content: Text(getPaymentMessage()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
