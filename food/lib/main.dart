import 'package:flutter/material.dart';
import 'package:food/pages/home/ui/home_page.dart';
import 'package:food/pages/splash/intro/intro_page.dart';
import 'package:food/pages/splash/splash_page.dart';

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
        "/": (context) => const SplashPage(),
        "/intro": (context) => const IntroPage(),
        "/home": (context) => const HomePage(),
      },
    );
  }
}
