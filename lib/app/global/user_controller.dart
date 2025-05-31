import 'package:get/get.dart';

class UserController extends GetxController {
  final user = Rxn<Map<String, dynamic>>();

  void setUser(Map<String, dynamic> userData) {
    user.value = userData;
  }

  void clearUser() {
    user.value = null;
  }

  bool get isLoggedIn => user.value != null;
}