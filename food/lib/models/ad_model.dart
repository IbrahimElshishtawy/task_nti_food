class AdModel {
  const AdModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.actionLabel,
    this.foodId,
  });

  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String actionLabel;
  final String? foodId;

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: '${json['id'] ?? ''}',
      title: '${json['title'] ?? ''}',
      subtitle: '${json['subtitle'] ?? ''}',
      imageUrl: '${json['imageUrl'] ?? json['image_url'] ?? ''}',
      actionLabel:
          '${json['actionLabel'] ?? json['action_label'] ?? 'Order now'}',
      foodId: json['foodId'] == null && json['food_id'] == null
          ? null
          : '${json['foodId'] ?? json['food_id']}',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'actionLabel': actionLabel,
      'foodId': foodId,
    };
  }
}
