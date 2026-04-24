class ReviewModel {
  const ReviewModel({
    required this.id,
    required this.userName,
    required this.avatarUrl,
    required this.comment,
    required this.rating,
    required this.createdAt,
  });

  final String id;
  final String userName;
  final String avatarUrl;
  final String comment;
  final double rating;
  final DateTime createdAt;

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: '${json['id'] ?? ''}',
      userName: '${json['userName'] ?? json['user_name'] ?? 'Guest'}',
      avatarUrl: '${json['avatarUrl'] ?? json['avatar_url'] ?? ''}',
      comment: '${json['comment'] ?? ''}',
      rating: _toDouble(json['rating'], fallback: 5),
      createdAt:
          DateTime.tryParse(
            '${json['createdAt'] ?? json['created_at'] ?? ''}',
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'avatarUrl': avatarUrl,
      'comment': comment,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static double _toDouble(dynamic value, {double fallback = 0}) {
    if (value is num) return value.toDouble();
    return double.tryParse('$value') ?? fallback;
  }
}
