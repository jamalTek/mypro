import 'package:flutter/services.dart';

import '../../../general_exports.dart';

final ThemeData darkThemeC = ThemeData(
  //colorSchemeSeed: MerathColors.primary,
  fontFamily: 'SF',
  brightness: Brightness.dark,

  scaffoldBackgroundColor: MerathColors.backgroundDark,
  primaryColor: MerathColors.primary,
  primarySwatch: primaryColor,
  appBarTheme: const AppBarTheme(
    toolbarTextStyle: TextStyle(color: MerathColors.textDark),
    backgroundColor: MerathColors.backgroundDark,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: MerathColors.textDark),
    bodyLarge: TextStyle(color: MerathColors.textDark),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: MerathColors.shapeBackgroundDark,
  ),
  dialogBackgroundColor: MerathColors.shapeBackgroundDark,
  cardColor: MerathColors.shapeBackgroundDark,
);

final ThemeData lightThemeC = ThemeData(
  //colorSchemeSeed: MerathColors.primary,
  fontFamily: 'SF',
  brightness: Brightness.light,
  // backgroundColor: MerathColors.white,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: MerathColors.primary,
    onPrimary: MerathColors.primary,
    secondary: MerathColors.accent,
    onSecondary: MerathColors.accent,
    error: MerathColors.red,
    onError: MerathColors.red,
    background: MerathColors.white,
    onBackground: MerathColors.shapeBackgroundLight,
    surface: MerathColors.white,
    onSurface: MerathColors.shapeBackgroundDark,
  ),
  scaffoldBackgroundColor: MerathColors.backgroundLight,
  appBarTheme: const AppBarTheme(
    toolbarTextStyle: TextStyle(color: MerathColors.textLight),
    backgroundColor: MerathColors.backgroundLight,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: IconThemeData(color: MerathColors.textLight),
    titleTextStyle: TextStyle(
      fontSize: 20,
      color: MerathColors.textLight,
      fontWeight: FontWeight.w500,
    ),
    elevation: 0,
  ),
  primaryColor: MerathColors.primary,
  primarySwatch: primaryColor,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: MerathColors.textLight),
    bodyLarge: TextStyle(color: MerathColors.textLight),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: MerathColors.shapeBackgroundLight,
  ),
);

const MaterialColor primaryColor =
    MaterialColor(_primaryColorPrimaryValue, <int, Color>{
  50: Color(0xFFE5F7F3),
  100: Color(0xFFBEEAE0),
  200: Color(0xFF92DCCC),
  300: Color(0xFF66CEB8),
  400: Color(0xFF46C4A8),
  500: Color(_primaryColorPrimaryValue),
  600: Color(0xFF21B291),
  700: Color(0xFF1BAA86),
  800: Color(0xFF16A27C),
  900: Color(0xFF0D936B),
});
const int _primaryColorPrimaryValue = 0xFF25B999;

const MaterialColor primaryColorAccent =
    MaterialColor(_primaryColorAccentValue, <int, Color>{
  100: Color(0xFFC3FFEB),
  200: Color(_primaryColorAccentValue),
  400: Color(0xFF5DFFC9),
  700: Color(0xFF43FFC0),
});
const int _primaryColorAccentValue = 0xFF90FFDA;
