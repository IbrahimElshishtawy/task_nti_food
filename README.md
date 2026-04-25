<div align="center">

<img src="screenshots/app_icon.png" alt="App Icon" width="120" height="120" style="border-radius: 30px;" />

# 🍔[Feasto Food]

### *Your Premium Food Delivery Experience*

> تطبيق توصيل طعام متكامل مبني بتقنية **Flutter** يوفر تجربة مستخدم استثنائية مع واجهات ثلاثية الأبعاد، دعم كامل للغتين العربية والإنجليزية، وهيكل معماري قابل للتوسع والربط بأي API.

---

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![GetX](https://img.shields.io/badge/GetX-State%20Management-8A2BE2?style=for-the-badge)](https://pub.dev/packages/get)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-orange?style=for-the-badge&logo=android)](https://flutter.dev)

</div>

---

## 📸 Preview

<div align="center">

| Splash Screen | Home | Food Details |
|:---:|:---:|:---:|
| ![Splash Screen](screenshots/splash.png) | ![Home Screen](screenshots/home.png) | ![Food Details](screenshots/details.png) |
| **3D Animated Splash** | **Premium Home UI** | **3D Food Cards** |

| Favorites | Cart | Checkout |
|:---:|:---:|:---:|
| ![Favorites](screenshots/favorites.png) | ![Cart](screenshots/cart.png) | ![Checkout](screenshots/checkout.png) |
| **Favorites System** | **Smart Cart** | **Easy Checkout** |

| Payment | Orders | Settings |
|:---:|:---:|:---:|
| ![Payment](screenshots/payment.png) | ![Orders](screenshots/orders.png) | ![Settings](screenshots/settings.png) |
| **Payment Methods** | **Order History** | **App Settings** |

</div>

---

## ✨ Features

### 🎨 UI / UX
- **3D Animated Splash Screen** — شاشة افتتاحية ثلاثية الأبعاد بأنيميشن سلس واحترافي
- **Premium Food Home UI** — واجهة رئيسية فاخرة مع تصميم عصري
- **3D Food Cards** — بطاقات طعام ثلاثية الأبعاد بتأثيرات بصرية مبهرة
- **Hero Animation** — انتقالات سلسة بين الشاشات باستخدام Hero Animations
- **Global Bottom Navigation Bar** — شريط تنقل سفلي موحد عبر جميع الشاشات

### 🍽️ Core Features
- **Smart Search** — بحث ذكي مع اقتراحات فورية
- **Favorites System** — نظام المفضلة لحفظ الأطباق المفضلة
- **Cart & Checkout** — سلة تسوق متكاملة مع تجربة دفع سلسة
- **Payment Method Selection** — اختيار طريقة الدفع المفضلة (بطاقة، كاش، محفظة)
- **Order History** — سجل كامل للطلبات السابقة
- **Notifications & Offers** — إشعارات العروض والتحديثات

### 🌍 Localization & Theming
- **Arabic / English Localization** — دعم كامل للغتين العربية والإنجليزية مع RTL/LTR
- **Dark / Light Mode** — الوضع الداكن والفاتح مع التبديل الفوري
- **Responsive Design** — تصميم متجاوب يعمل على جميع أحجام الشاشات

### ⚙️ Technical
- **GetX State Management** — إدارة حالة قوية وسريعة باستخدام GetX
- **API Ready Architecture** — هيكل معماري جاهز للربط بأي API في أي وقت
- **Mock Data Support** — بيانات تجريبية متكاملة لتجربة التطبيق فوراً
- **Local Storage** — حفظ البيانات محلياً باستخدام GetStorage
- **Optimized Performance** — أداء عالٍ مع Shimmer Loading وCached Images

---

## 📁 Project Structure

```
lib/
│
├── core/                        # القلب الأساسي للتطبيق
│   ├── constants/               # الثوابت (الألوان، النصوص، الروابط)
│   ├── utils/                   # الأدوات المساعدة والـ helpers
│   └── errors/                  # معالجة الأخطاء العامة
│
├── data/                        # طبقة البيانات
│   ├── mock/                    # البيانات التجريبية (Mock Data)
│   └── repositories/            # الـ Repositories للتواصل مع المصادر
│
├── models/                      # نماذج البيانات (Data Models)
│   ├── food_model.dart
│   ├── order_model.dart
│   ├── user_model.dart
│   └── cart_model.dart
│
├── services/                    # الخدمات الخارجية
│   ├── api_service.dart         # خدمة Dio للتواصل مع API
│   ├── storage_service.dart     # خدمة GetStorage للتخزين المحلي
│   └── notification_service.dart
│
├── controllers/                 # GetX Controllers (إدارة الحالة)
│   ├── home_controller.dart
│   ├── cart_controller.dart
│   ├── favorites_controller.dart
│   ├── auth_controller.dart
│   └── settings_controller.dart
│
├── views/                       # شاشات التطبيق (UI Screens)
│   ├── splash/
│   ├── home/
│   ├── details/
│   ├── cart/
│   ├── checkout/
│   ├── favorites/
│   ├── orders/
│   ├── payment/
│   ├── notifications/
│   └── settings/
│
├── widgets/                     # الـ Widgets المعاد استخدامها
│   ├── food_card_widget.dart
│   ├── bottom_nav_bar.dart
│   ├── custom_button.dart
│   └── shimmer_loader.dart
│
├── routes/                      # إدارة التنقل بين الشاشات
│   ├── app_routes.dart          # أسماء المسارات
│   └── app_pages.dart           # تعريف الصفحات والـ Bindings
│
├── bindings/                    # GetX Bindings لحقن التبعيات
│   ├── home_binding.dart
│   ├── cart_binding.dart
│   └── initial_binding.dart
│
├── translations/                # ملفات الترجمة
│   ├── ar_EG.dart               # اللغة العربية
│   ├── en_US.dart               # اللغة الإنجليزية
│   └── app_translations.dart
│
├── theme/                       # إعدادات الثيم
│   ├── app_theme.dart           # تعريف Light & Dark Theme
│   ├── app_colors.dart          # الألوان الرئيسية
│   └── app_text_styles.dart     # أنماط الخطوط
│
└── main.dart                    # نقطة بداية التطبيق
```

---

## 📦 Packages Used

| Package | Version | Usage |
|:---|:---:|:---|
| [`get`](https://pub.dev/packages/get) | ^4.6.6 | State Management, Navigation & Dependency Injection |
| [`dio`](https://pub.dev/packages/dio) | ^5.4.0 | HTTP Client للتواصل مع REST APIs |
| [`get_storage`](https://pub.dev/packages/get_storage) | ^2.1.1 | التخزين المحلي السريع للبيانات |
| [`cached_network_image`](https://pub.dev/packages/cached_network_image) | ^3.3.1 | تحميل وتخزين الصور من الإنترنت |
| [`carousel_slider`](https://pub.dev/packages/carousel_slider) | ^4.2.1 | عرض البانرات والعروض الدائرية |
| [`shimmer`](https://pub.dev/packages/shimmer) | ^3.0.0 | تأثير التحميل الجميل (Skeleton Loading) |
| [`flutter_rating_bar`](https://pub.dev/packages/flutter_rating_bar) | ^4.0.1 | شريط تقييم النجوم |
| [`google_fonts`](https://pub.dev/packages/google_fonts) | ^6.1.0 | خطوط Google المتنوعة والجميلة |
| [`animations`](https://pub.dev/packages/animations) | ^2.0.11 | انتقالات وأنيميشن احترافية |

---

## 🚀 Installation & Setup

### Prerequisites
تأكد من تثبيت المتطلبات التالية على جهازك:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) `>= 3.0.0`
- [Dart SDK](https://dart.dev/get-dart) `>= 3.0.0`
- Android Studio / VS Code
- Android Emulator أو iOS Simulator

### Steps

```bash
# 1. Clone the repository
git clone PROJECT_URL

# 2. Navigate to project directory
cd PROJECT_NAME

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Google Play)
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## 🌐 API Integration

التطبيق حالياً يعمل بـ **Mock Data** وجاهز للربط بأي Backend API.

لربط API حقيقي، عدّل الملف التالي:

```dart
// lib/core/constants/api_constants.dart

class ApiConstants {
  static const String baseUrl = 'https://your-api-url.com/api/v1';
  static const String foodsEndpoint = '/foods';
  static const String ordersEndpoint = '/orders';
  // ...
}
```

ثم في `ApiService` عبر `Dio`، كل شيء جاهز للعمل فوراً ✅

---

## 🌍 Localization

يدعم التطبيق اللغتين **العربية** و**الإنجليزية** بشكل كامل مع دعم RTL/LTR.

```dart
// تغيير اللغة من أي مكان في التطبيق
Get.updateLocale(Locale('ar', 'EG')); // عربي
Get.updateLocale(Locale('en', 'US')); // English
```

---

## 🎨 Theme

```dart
// تبديل الثيم من أي مكان
Get.changeThemeMode(ThemeMode.dark);  // وضع داكن
Get.changeThemeMode(ThemeMode.light); // وضع فاتح
```

---

## 📂 Screenshots Folder Structure

```
screenshots/
├── splash.png
├── home.png
├── details.png
├── favorites.png
├── cart.png
├── checkout.png
├── payment.png
├── orders.png
├── notifications.png
└── settings.png
```

---

## 🗺️ Roadmap

- [x] 3D Splash Screen
- [x] Home UI with Categories
- [x] Food Details with 3D Cards
- [x] Cart & Checkout
- [x] Favorites System
- [x] Order History
- [x] Notifications
- [x] Settings Screen
- [x] Dark / Light Mode
- [x] Arabic / English Localization
- [ ] Real API Integration
- [ ] User Authentication
- [ ] Real-time Order Tracking
- [ ] Push Notifications (Firebase)
- [ ] Payment Gateway Integration

---

## 🤝 Contributing

المساهمات مرحب بها! إذا أردت المساهمة:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Developer

<div align="center">

**Ibrahim Elshishtawy**

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/IbrahimElshishtawy)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ibrahim-el-shishtawy-0a67b334a)
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:shishtawyhima@gmail.com)

---

*صُنع بـ ❤️ و Flutter*

⭐ **إذا أعجبك المشروع، لا تنسَ إعطاءه نجمة!** ⭐

</div>
