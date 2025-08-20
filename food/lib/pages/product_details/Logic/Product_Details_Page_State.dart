// import 'package:flutter/material.dart';
// import 'package:food/data/api_model.dart';
// import 'package:food/pages/product_details/product_details_page.dart';

// abstract class _ProductDetailsPageState extends State<ProductDetailsPage>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeIn;
//   bool showDetails = false;

//   List<ApiModel> suggestions = []; // Suggestions to display

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//     _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
//     _controller.forward();

//     // Load suggestions (mock أو API call)
//     loadSuggestions();
//   }

//   void loadSuggestions() {
//     // ممكن تعمل هنا call للـ API بدل الموك
//     suggestions = suggestedRecipes;
//     setState(() {});
//   }

//   void toggleDetails() {
//     setState(() => showDetails = !showDetails);
//   }

//   void addToCart(ApiModel recipe) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("${recipe.name} has been added to cart")),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
