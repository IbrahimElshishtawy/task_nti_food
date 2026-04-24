import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/notifications_controller.dart';
import '../../models/app_notification_model.dart';
import '../../theme/app_colors.dart';
import '../../widgets/empty_state.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notifications'.tr),
        actions: <Widget>[
          Obx(
            () => TextButton(
              onPressed: controller.unreadCount == 0
                  ? null
                  : controller.markAllAsRead,
              child: Text('mark_all_read'.tr),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return EmptyState(
            icon: Icons.notifications_none_rounded,
            title: 'no_notifications'.tr,
            message: 'no_notifications_message'.tr,
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 126),
          itemCount: controller.notifications.length,
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return _NotificationCard(
              notification: notification,
              onTap: () => controller.openNotification(notification),
              onMarkRead: () => controller.markAsRead(notification.id),
            );
          },
        );
      }),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.notification,
    required this.onTap,
    required this.onMarkRead,
  });

  final AppNotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onMarkRead;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: notification.isRead
                ? colorScheme.outlineVariant
                : AppColors.primary.withValues(alpha: .34),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: notification.isRead
                  ? Colors.black.withValues(alpha: .04)
                  : AppColors.primaryDark.withValues(alpha: .12),
              blurRadius: 28,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: CachedNetworkImage(
                    imageUrl: notification.imageUrl,
                    width: 84,
                    height: 84,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 84,
                      height: 84,
                      color: colorScheme.surfaceContainerHighest,
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 84,
                      height: 84,
                      color: colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.campaign_rounded),
                    ),
                  ),
                ),
                Positioned(
                  right: -6,
                  bottom: -6,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[AppColors.primary, AppColors.butter],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: .28),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      _typeIcon(notification.type),
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          notification.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                      if (!notification.isRead) ...<Widget>[
                        const SizedBox(width: 8),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: AppColors.tomato,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    notification.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.schedule_rounded,
                        size: 15,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          _timeAgo(notification.createdAt),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        TextButton(
                          onPressed: onMarkRead,
                          child: Text('unread'.tr),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _typeIcon(AppNotificationType type) {
    return switch (type) {
      AppNotificationType.offer => Icons.local_offer_rounded,
      AppNotificationType.order => Icons.delivery_dining_rounded,
      AppNotificationType.system => Icons.notifications_active_rounded,
      AppNotificationType.newFood => Icons.restaurant_menu_rounded,
    };
  }

  String _timeAgo(DateTime value) {
    final difference = DateTime.now().difference(value);
    if (difference.inMinutes < 1) return 'just_now'.tr;
    if (difference.inHours < 1) {
      return 'minutes_ago'.trParams(<String, String>{
        'count': '${difference.inMinutes}',
      });
    }
    if (difference.inDays < 1) {
      return 'hours_ago'.trParams(<String, String>{
        'count': '${difference.inHours}',
      });
    }
    return 'days_ago'.trParams(<String, String>{
      'count': '${difference.inDays}',
    });
  }
}
