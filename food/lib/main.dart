import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/constants/storage_keys.dart';
import 'controllers/language_controller.dart';
import 'bindings/initial_binding.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'translations/app_translations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initStorage();
  runApp(const FoodApp());
}

Future<void> _initStorage() async {
  if (!Platform.isAndroid) {
    await GetStorage.init();
    return;
  }

  final storageDir = Directory('/data/user/0/com.example.food/files');
  if (!storageDir.existsSync()) {
    storageDir.createSync(recursive: true);
  }
  await GetStorage('GetStorage', storageDir.path).initStorage;
}

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final savedTheme = storage.read<String>(StorageKeys.themeMode);
    final savedLanguage = LanguageController.normalizeLanguage(
      storage.read<String>(StorageKeys.language),
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TasteTrail Food',
      translations: AppTranslations(),
      locale: Locale(savedLanguage),
      fallbackLocale: const Locale('en'),
      supportedLocales: const <Locale>[Locale('en'), Locale('ar')],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      defaultTransition: Transition.fadeIn,
    );
  }
}
