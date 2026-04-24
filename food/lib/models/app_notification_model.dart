import 'package:get/get.dart';

enum AppNotificationType { offer, order, system, newFood }

class AppNotificationModel {
  const AppNotificationModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.bodyAr,
    required this.bodyEn,
    required this.imageUrl,
    required this.type,
    required this.createdAt,
    required this.isRead,
    required this.actionRoute,
    this.foodId,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String bodyAr;
  final String bodyEn;
  final String imageUrl;
  final AppNotificationType type;
  final DateTime createdAt;
  final bool isRead;
  final String actionRoute;
  final String? foodId;

  String get title => Get.locale?.languageCode == 'ar' ? titleAr : titleEn;

  String get body => Get.locale?.languageCode == 'ar' ? bodyAr : bodyEn;

  AppNotificationModel copyWith({bool? isRead}) {
    return AppNotificationModel(
      id: id,
      titleAr: titleAr,
      titleEn: titleEn,
      bodyAr: bodyAr,
      bodyEn: bodyEn,
      imageUrl: imageUrl,
      type: type,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
      actionRoute: actionRoute,
      foodId: foodId,
    );
  }
}
