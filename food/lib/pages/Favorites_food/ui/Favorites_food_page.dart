import 'package:flutter/material.dart';

class FavoritesFoodPage extends StatefulWidget {
  const FavoritesFoodPage({super.key});

  @override
  State<FavoritesFoodPage> createState() => _FavoritesFoodPageState();
}
@override
State<>

class _FavoritesFoodPageState extends State<FavoritesFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(212, 231, 148, 4),
        title: Text('Favorites food', style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}