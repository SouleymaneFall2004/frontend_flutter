import 'package:hive/hive.dart';

class HiveDb {
  static final HiveDb _instance = HiveDb._();

  factory HiveDb() => _instance;

  HiveDb._();

  late Box box;

  Future<void> init() async {
    box = await Hive.openBox('box');
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
