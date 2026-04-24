import 'package:get/get.dart';

import '../data/mock_notifications_data.dart';
import '../data/repositories/food_repository.dart';
import '../models/app_notification_model.dart';
import '../routes/app_routes.dart';
import 'navigation_controller.dart';

class NotificationsController extends GetxController {
  NotificationsController(this._repository);

  final FoodRepository _repository;
  final RxList<AppNotificationModel> notifications =
      <AppNotificationModel>[].obs;

  int get unreadCount {
    return notifications.where((notification) => !notification.isRead).length;
  }

  @override
  void onInit() {
    super.onInit();
    notifications.assignAll(MockNotificationsData.notifications);
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((item) => item.id == id);
    if (index == -1 || notifications[index].isRead) return;
    notifications[index] = notifications[index].copyWith(isRead: true);
  }

  void markAllAsRead() {
    notifications.assignAll(
      notifications.map((item) => item.copyWith(isRead: true)),
    );
  }

  Future<void> openNotification(AppNotificationModel notification) async {
    markAsRead(notification.id);

    final foodId = notification.foodId;
    if (foodId != null && foodId.isNotEmpty) {
      final food = await _repository.getFoodDetails(foodId);
      Get.toNamed(AppRoutes.details, arguments: food);
      return;
    }

    if (!Get.isRegistered<NavigationController>()) return;
    final navigationController = Get.find<NavigationController>();
    switch (notification.actionRoute) {
      case AppRoutes.home:
        navigationController.changeTab(0);
      case AppRoutes.orders:
        navigationController.changeTab(3);
      case AppRoutes.settings:
        navigationController.changeTab(5);
    }
  }
}
