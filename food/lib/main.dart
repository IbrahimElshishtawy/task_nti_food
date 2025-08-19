import 'package:flutter/material.dart';

void main() {
  runApp(const food_app());
}

// ignore: camel_case_types
class food_app extends StatelessWidget {
  const food_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Restaurant App",
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: "Poppins"),
      initialRoute: "/",
      routes: {
        // "/": (context) => const SplashPage(),
        // "/intro": (context) => const IntroPage(),
        // "/home": (context) => const HomePage(),
        // "/food_detail": (context) => const FoodDetailPage(),
        // "/cart": (context) => const CartPage(),
        // "/checkout": (context) => const CheckoutPage(),
        // "/profile": (context) => const ProfilePage(),
      },
    );
  }
}
