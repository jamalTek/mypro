import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';

class MerathColors extends GetxController {
  static const Color primary = Color(0xFF208E73);
  static Color noAutContainer =
      isDark ? const Color(0xff1B2141) : const Color(0xFFe4e4e4);
  static Color bottomBar = const Color(0xff1B2141);
  static const Color secondary = Color(0xFFEAC93F);
  static const Color thirdly = Color(0xFFF59224);
  static const Color active = CupertinoColors.activeBlue;
  static const Color activeNotification = Color(0xFFE3F6FA);
  static const Color activeSlider = Color(0xFF2348C2);
  static const Color inactiveSlider = Color(0xFFB3AA99);
  static const Color thumbSlider = Color(0xFFF59224);
  static const Color gradient1 = Color(0xFF029ED8);
  static const Color gradient2 = Color(0xFF141EFF);
  static const Color activeBubble = Color(0xFFF34379);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static Color backgroundLogin = const Color(0xFFCAE3FA);
  static Color card = const Color(0xFFFFFFFF);
  static const Color logoBackground = Color(0xFF28324E);
  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[gradient1, gradient2],
    stops: <double>[0.0, 1.0],
  );
  static const Color requiredField = Color(0xFFE25C6A);
  static const Color blue = Color(0xFF0162E9);
  static const Color red = Color(0xFFE90109);
  static const Color blueEnd = Color(0xFF0CADDE);
  static const Color pink = Color(0xFFF10779);

  static const Color purple = Color(0xFF673AB7);
  static const Color purpleEnd = Color(0xFF8749EF);
  static const Color lightGreen = Color(0xFFA3CBC1);
  static const Color green = Color(0xFF148D16);
  static const Color greenEnd = Color(0xFF43D2A4);
  static const Color gold = Color(0xFFF66E31);
  static const Color goldEnd = Color(0xFFD8B186);
  static const Color grey = Color(0xFFA0A0A0);
  static const Color greyEnd = Color(0xFFA8B4D6);
  static const Color grey_3 = Color(0xFFf7f7f7);
  static const Color grey_5 = Color(0xFFf2f2f2);
  static const Color grey_10 = Color(0xFFe6e6e6);
  static const Color grey_20 = Color(0xFFcccccc);
  static const Color grey_40 = Color(0xFF999999);
  static const Color grey_60 = Color(0xFF666666);
  static const Color grey_80 = Color(0xFF37474F);
  static const Color grey_90 = Color(0xFF263238);
  static const Color grey_95 = Color(0xFF1a1a1a);
  static const Color grey_100_ = Color(0xFF0d0d0d);

  // Light Theme Colors
  static const Color textLight = Color(0xff252525);
  static const Color backgroundLight = Color(0xffffffff);
  static const Color shapeBackgroundLight = Color(0xffF0F0F0);
  //static const Color primaryLight = Color(0xFF208E73);
  //static const Color accentLight = Color(0xFF25B999);

  // Dark Theme Colors
  static const Color textDark = Color(0xffffffff);
  static const Color backgroundDark = Color(0xff222831);
  static const Color shapeBackgroundDark = Color(0xff29303B);
  //static const Color primaryDark = Color(0xFF208E73);
  //static const Color accentDark = Color(0xFF25B999);

  // Dynamic Colors
  static Color textColor = const Color(0xff252525);
  static Color background = const Color(0xffffffff);
  static Color shapeBackground = const Color(0xffF0F0F0);
  //static Color primary = const Color(0xff2F99B4);
  static const Color accent = Color(0xFF25B999);

  void updateColor(ThemeMode themeMode) {
    final bool isLight = themeMode == ThemeMode.light;
    background = isLight ? backgroundLight : backgroundDark;
    // primary = isLight ? primaryLight : primaryDark;
    // accent = isLight ? accentLight : accentDark;
    shapeBackground = isLight ? shapeBackgroundLight : shapeBackgroundDark;
    textColor = isLight ? textLight : textDark;
    update();
    //log(Theme.of(Get.context!).textTheme.bodyText1!.color!.toString());
  }

  @override
  void onReady() {
    super.onReady();
    updateColor(Get.isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
