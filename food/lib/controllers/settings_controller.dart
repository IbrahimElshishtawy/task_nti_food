import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/storage_keys.dart';
import '../services/storage_service.dart';
import 'language_controller.dart';

class SettingsController extends GetxController {
  SettingsController(this._storageService);

  final StorageService _storageService;
  final RxBool isDarkMode = false.obs;
  final RxBool notificationsEnabled = true.obs;
  final RxString selectedLanguage = 'English'.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value =
        _storageService.read<String>(StorageKeys.themeMode) == 'dark';
    notificationsEnabled.value =
        _storageService.read<bool>(StorageKeys.notificationsEnabled) ?? true;
    selectedLanguage.value =
        LanguageController.normalizeLanguage(
              _storageService.read<String>(StorageKeys.language),
            ) ==
            'ar'
        ? 'Arabic'
        : 'English';
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    _storageService.write(StorageKeys.themeMode, value ? 'dark' : 'light');
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
    _storageService.write(StorageKeys.notificationsEnabled, value);
  }

  void changeLanguage(String language) {
    final normalized = LanguageController.normalizeLanguage(language);
    selectedLanguage.value = normalized == 'ar' ? 'Arabic' : 'English';
    _storageService.write(StorageKeys.language, normalized);
  }

  void logout() {
    Get.snackbar('logged_out'.tr, 'logged_out_message'.tr);
  }
}
