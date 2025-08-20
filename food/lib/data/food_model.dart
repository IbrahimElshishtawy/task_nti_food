class FoodModel {
  final int id;
  final String imageUrl;
  final String title;

  FoodModel({required this.id, required this.imageUrl, required this.title});

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json["id"] ?? 0, // لو الـ API ما رجعش id نحط 0 افتراضياً
      imageUrl: json["image"] ?? "",
      title: json["title"] ?? "No Title",
    );
  }
}
