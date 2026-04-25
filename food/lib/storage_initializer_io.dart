import 'dart:io';

import 'package:get_storage/get_storage.dart';

Future<void> initStorage() async {
  if (!Platform.isAndroid) {
    await GetStorage.init();
    return;
  }

  final storageDir = Directory('/data/user/0/com.example.food/app_flutter');
  if (!storageDir.existsSync()) {
    storageDir.createSync(recursive: true);
  }
  await GetStorage('GetStorage', storageDir.path).initStorage;
}
