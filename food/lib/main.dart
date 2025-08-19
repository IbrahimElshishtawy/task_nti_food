import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
