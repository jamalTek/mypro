import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import '../../general_exports.dart';

class MyAppController extends GetxController {
  bool isInternetConnect = true;
  final ThemeData darkTheme = darkThemeC;
  final ThemeData lightTheme = lightThemeC;
  bool isLight = !Get.isDarkMode;
  final box = GetStorage();
  bool isFirstTime = false;
  List? notifications;
  void fixSystemUi({bool? isDark}) {
    final bool isDarkMode = isDark ?? Get.isDarkMode;
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            MerathColors.background, // navigation bar color
        statusBarColor: Colors.transparent, // status bar color
        statusBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark, // status bar icons' color
        statusBarBrightness: isDarkMode
            ? Brightness.dark
            : Brightness.light, // status bar icons' color (IOS)
        systemNavigationBarIconBrightness: isDarkMode
            ? Brightness.dark
            : Brightness.light, //navigation bar icons' color
      ),
    );
  }

  void changeTheme() {
    Get.changeThemeMode(
      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
    fixSystemUi(isDark: !Get.isDarkMode);
    isLight = !Get.isDarkMode;
    update();

    Get.find<MerathColors>()
        .updateColor(!Get.isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
