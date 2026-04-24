import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/storage_keys.dart';
import '../services/storage_service.dart';

class LanguageController extends GetxController {
  LanguageController(this._storageService);

  final StorageService _storageService;
  final RxString languageCode = 'en'.obs;

  Locale get locale => Locale(languageCode.value);

  String get selectedLanguage =>
      languageCode.value == 'ar' ? 'Arabic' : 'English';

  @override
  void onInit() {
    super.onInit();
    languageCode.value = normalizeLanguage(
      _storageService.read<String>(StorageKeys.language),
    );
  }

  void changeLanguage(String value) {
    final normalized = normalizeLanguage(value);
    languageCode.value = normalized;
    _storageService.write(StorageKeys.language, normalized);
    Get.updateLocale(Locale(normalized));
  }

  static String normalizeLanguage(String? value) {
    final normalized = (value ?? 'en').toLowerCase();
    if (normalized == 'ar' || normalized == 'arabic') return 'ar';
    return 'en';
  }
}
