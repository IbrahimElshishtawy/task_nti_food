import '../models/app_notification_model.dart';
import '../routes/app_routes.dart';

class MockNotificationsData {
  const MockNotificationsData._();

  static final List<AppNotificationModel>
  notifications = <AppNotificationModel>[
    AppNotificationModel(
      id: 'noti-1',
      titleAr: 'خصم 30% على البيتزا',
      titleEn: '30% off pizza',
      bodyAr: 'استمتع بعرض البيتزا اليوم على مارجريتا وبيبروني.',
      bodyEn: 'Enjoy today pizza deal on Margherita and pepperoni picks.',
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=600&q=80',
      type: AppNotificationType.offer,
      createdAt: DateTime(2026, 4, 25, 10, 15),
      isRead: false,
      actionRoute: AppRoutes.details,
      foodId: '4',
    ),
    AppNotificationModel(
      id: 'noti-2',
      titleAr: 'عرض برجر اليوم',
      titleEn: 'Burger deal of the day',
      bodyAr: 'برجر ترافل فاير مع بطاطس وصوص بسعر خاص.',
      bodyEn: 'Truffle Flame Burger with fries and sauce at a special price.',
      imageUrl:
          'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=600&q=80',
      type: AppNotificationType.offer,
      createdAt: DateTime(2026, 4, 25, 9, 0),
      isRead: false,
      actionRoute: AppRoutes.details,
      foodId: '1',
    ),
    AppNotificationModel(
      id: 'noti-3',
      titleAr: 'مشروب مجاني مع كل أوردر',
      titleEn: 'Free drink with every order',
      bodyAr: 'اطلب أي وجبة رئيسية واحصل على مشروب بارد مجاني.',
      bodyEn: 'Order any main meal and get a free cold drink.',
      imageUrl:
          'https://images.unsplash.com/photo-1517701604599-bb29b565090c?auto=format&fit=crop&w=600&q=80',
      type: AppNotificationType.offer,
      createdAt: DateTime(2026, 4, 24, 21, 30),
      isRead: true,
      actionRoute: AppRoutes.details,
      foodId: '31',
    ),
    AppNotificationModel(
      id: 'noti-4',
      titleAr: 'حلويات جديدة وصلت',
      titleEn: 'New desserts arrived',
      bodyAr: 'جرب تشيز كيك لوتس وكنافة الكريمة من قائمة الحلويات.',
      bodyEn: 'Try Lotus cheesecake and kunafa cream from the dessert menu.',
      imageUrl:
          'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?auto=format&fit=crop&w=600&q=80',
      type: AppNotificationType.newFood,
      createdAt: DateTime(2026, 4, 24, 18, 45),
      isRead: false,
      actionRoute: AppRoutes.details,
      foodId: '25',
    ),
    AppNotificationModel(
      id: 'noti-5',
      titleAr: 'توصيل مجاني اليوم',
      titleEn: 'Free delivery today',
      bodyAr: 'التوصيل علينا لكل الطلبات فوق 15 دولار حتى منتصف الليل.',
      bodyEn: 'Delivery is on us for orders above until midnight.',
      imageUrl:
          'https://images.unsplash.com/photo-1526367790999-0150786686a2?auto=format&fit=crop&w=600&q=80',
      type: AppNotificationType.system,
      createdAt: DateTime(2026, 4, 24, 12, 10),
      isRead: true,
      actionRoute: AppRoutes.home,
    ),
    AppNotificationModel(
      id: 'noti-6',
      titleAr: 'عروض نهاية الأسبوع',
      titleEn: 'Weekend offers',
      bodyAr: 'اختيارات بيتزا وبرجر وحلويات بأسعار مخفضة لمدة يومين.',
      bodyEn: 'Pizza, burger, and dessert picks at lower prices for two days.',
      imageUrl:
          'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=600&q=80',
      type: AppNotificationType.offer,
      createdAt: DateTime(2026, 4, 23, 20, 20),
      isRead: false,
      actionRoute: AppRoutes.home,
    ),
    AppNotificationModel(
      id: 'noti-7',
      titleAr: 'طبق صحي موصى به',
      titleEn: 'Recommended healthy bowl',
      bodyAr: 'بول الفراخ بالأفوكادو مناسب لغداء سريع وخفيف.',
      bodyEn: 'The avocado chicken bowl is a bright pick for a light lunch.',
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=600&q=80',
      type: AppNotificationType.newFood,
      createdAt: DateTime(2026, 4, 23, 14, 5),
      isRead: true,
      actionRoute: AppRoutes.details,
      foodId: '21',
    ),
    AppNotificationModel(
      id: 'noti-8',
      titleAr: 'طلبك في الطريق',
      titleEn: 'Your order is on the way',
      bodyAr: 'المندوب استلم الطلب وسيصل إلى عنوانك قريباً.',
      bodyEn: 'The courier picked up your order and will arrive soon.',
      imageUrl:
          'https://images.unsplash.com/photo-1526367790999-0150786686a2?auto=format&fit=crop&w=600&q=80',
      type: AppNotificationType.order,
      createdAt: DateTime(2026, 4, 22, 19, 40),
      isRead: true,
      actionRoute: AppRoutes.orders,
    ),
  ];
}
