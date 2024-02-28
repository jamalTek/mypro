import 'dart:convert';

import '../../general_exports.dart';

class UserController extends GetxController {
  Map? userData;

  void updateUserData(dynamic data) {
    if (data is! Map) {
      data = jsonDecode(data.toString());
    }
    if (data == null) {
      userData = null;
      return;
    } else {
      if (userData == null) {
        userData = data;
      } else {
        userData!.addAll(data);
      }
    }
    box.write(kUserData, userData);
    consoleLog(userData);
  }

  @override
  void onInit() {
    super.onInit();
    userData = box.read(kUserData);
    consoleLog(userData);
  }
}
