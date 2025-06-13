import 'package:hive/hive.dart';

class HiveDb {
  static final HiveDb _instance = HiveDb._();

  factory HiveDb() => _instance;

  HiveDb._();

  static const _userKey = 'user';
  static const _tokenKey = 'token';

  late Box box;

  Future<void> init() async {
    box = await Hive.openBox('box');
  }

  Future<void> saveData(String key, dynamic value) async {
    await box.put(key, value);
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    await saveData(_userKey, user);
  }

  Future<void> saveToken(String token) async {
    await saveData(_tokenKey, token);
  }

  Map<String, dynamic>? getUser() {
    return getData(_userKey);
  }

  String? getToken() {
    return getData(_tokenKey);
  }

  dynamic getData(String key) {
    return box.get(key);
  }

  Future<void> clearData() async {
    await box.clear();
  }
}
