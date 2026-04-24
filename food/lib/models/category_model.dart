class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.colorHex,
  });

  final String id;
  final String name;
  final String imageUrl;
  final String colorHex;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: '${json['id'] ?? ''}',
      name: '${json['name'] ?? ''}',
      imageUrl: '${json['imageUrl'] ?? json['image_url'] ?? ''}',
      colorHex: '${json['colorHex'] ?? json['color_hex'] ?? 'FFF6EA'}',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'colorHex': colorHex,
    };
  }
}
