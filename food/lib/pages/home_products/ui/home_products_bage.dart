import 'package:flutter/material.dart';
import 'package:food/data/api_client.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/home/widget/product_card.dart';
import 'package:food/pages/product_details/product_details_page.dart';

class HomeProductsPage extends StatefulWidget {
  final Function(ApiModel) onCartAdded;

  const HomeProductsPage({super.key, required this.onCartAdded});

  @override
  State<HomeProductsPage> createState() => _HomeProductsPageState();
}

class _HomeProductsPageState extends State<HomeProductsPage>
    with SingleTickerProviderStateMixin {
  final ApiClient apiClient = ApiClient();
  List<ApiModel> recipes = [];
  bool isLoading = true;
  final Set<int> favorites = {};

  bool showMenu = false; // 🔹 عشان نتحكم في إظهار/إخفاء المنيو
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    fetchData();

    // 🔹 أنيميشن الكنترولر
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final data = await apiClient.fetchRecipes();
      setState(() {
        recipes = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching recipes: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggleFavorite(int index) {
    setState(() {
      if (favorites.contains(index)) {
        favorites.remove(index);
      } else {
        favorites.add(index);
      }
    });
  }

  void toggleMenu() {
    setState(() {
      showMenu = !showMenu;
      if (showMenu) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        /// 🔹 سلايدر أو بنرات
        SizedBox(
          height: 150,
          child: PageView(
            children: [
              bannerItem("assets/image/food1.jpeg"),
              bannerItem(
                "https://via.placeholder.com/400x150.png?text=عرض+خاص",
              ),
              bannerItem("https://via.placeholder.com/400x150.png?text=هدية+3"),
            ],
          ),
        ),
        const SizedBox(height: 16),

        /// 🔹 Scroll للخصومات
        SizedBox(
          height: 60,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              discountCard("خصم 20% على البيتزا"),
              discountCard("عرض 1+1 على البرجر"),
              discountCard("خصم 15% على السلطات"),
              discountCard("هدايا مع الطلبات فوق 200ج"),
            ],
          ),
        ),
        const SizedBox(height: 16),

        /// 🔹 ٤ أزرار (منيو - مكان - ترابيزة - طبق اليوم)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              actionButton(Icons.restaurant_menu, "المنيو", toggleMenu),
              actionButton(Icons.location_on, "مكان المطعم", () {
                debugPrint("مكان المطعم");
              }),
              actionButton(Icons.event_seat, "حجز ترابيزة", () {
                debugPrint("حجز ترابيزة");
              }),
              actionButton(Icons.local_dining, "طبق اليوم", () {
                debugPrint("طبق اليوم");
              }),
            ],
          ),
        ),
        const SizedBox(height: 20),

        /// 🔹 قائمة المنتجات (بأنيميشن عند فتح المنيو)
        if (showMenu)
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetailsPage(recipe: recipes[index]),
                        ),
                      );
                    },
                    child: ProductCard(
                      recipe: recipes[index],
                      index: index,
                      favorites: favorites,
                      addToCart: widget.onCartAdded,
                      toggleFavorite: toggleFavorite,
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  /// 🔹 عنصر البنر
  Widget bannerItem(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(imageUrl, fit: BoxFit.cover),
      ),
    );
  }

  /// 🔹 كارت خصومات
  Widget discountCard(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// 🔹 زرار أكشن (أيقونة + نص)
  Widget actionButton(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(40),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            child: Icon(icon, color: Colors.redAccent, size: 28),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
