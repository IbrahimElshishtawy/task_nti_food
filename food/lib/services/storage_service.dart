import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  final GetStorage _box = GetStorage();

  T? read<T>(String key) => _box.read<T>(key);

  Future<void> write(String key, dynamic value) => _box.write(key, value);

  Future<void> remove(String key) => _box.remove(key);

  List<Map<String, dynamic>> readJsonList(String key) {
    final raw = _box.read<List<dynamic>>(key) ?? const <dynamic>[];
    return raw
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  Future<void> writeJsonList(
    String key,
    List<Map<String, dynamic>> value,
  ) {
    return _box.write(key, value);
  }
}
