import 'package:http/http.dart' as http;

import '../utils/const.dart';

class Api {
  static final Api _instance = Api._();

  factory Api() => _instance;

  Api._();

  String get baseUrl => Const.baseUrl;

  Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.get(url, headers: headers);
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.post(url, headers: headers, body: body);
  }
}
