import '../../general_exports.dart';

//******************* Current App Mode *******************//
//*** change current mode when you want to edit mode ***//

const AppMode currentMode = AppMode.prod;

enum AppMode {
  // Production Mode
  prod,
  // Development Mode
  dev,
  // Demo Mode
  demo,
}

String testImage =
    'https://images.unsplash.com/photo-1512632578888-169bbbc64f33?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80';
bool isDark = false;
Map<String, TextStyle> textStyles = MerathTextStyles().styles;
bool viewLog = true;
Duration generalAnimationDuration = const Duration(milliseconds: 400);

LocalStorage box = Get.find<LocalStorage>();
UserController userController = Get.find<UserController>();
