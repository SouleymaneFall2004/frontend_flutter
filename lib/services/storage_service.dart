import 'package:hive/hive.dart';

class StorageService {
  static final StorageService _instance = StorageService._();
  factory StorageService() => _instance;
  StorageService._();

  late Box box;

  Future<void> init() async {
    box = await Hive.openBox('mybox');
  }

  Future<void> saveData(String key, dynamic value) async {
    await box.put(key, value);
  }

  dynamic getData(String key) {
    return box.get(key);
  }

  Future<void> clearData() async {
    await box.clear();
  }
}