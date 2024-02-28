//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_storage/get_storage.dart';
import 'package:showcaseview/showcaseview.dart';

import 'general_exports.dart';
import 'logic/controllers/notification_controller.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp();
  Get.put<LocalStorage>(LocalStorage());
  Get.put<MyAppController>(MyAppController());
  Get.put<UserController>(UserController());
  Get.put<LanguageController>(LanguageController());
  Get.put<MerathColors>(MerathColors());
  Get.put<NotificationController>(NotificationController());
  Get.put<ReminderController>(ReminderController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MyAppController myAppController = Get.find<MyAppController>();
    // final bool? isSaveModeDark = GetStorage().read(kIsDark);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myAppController.lightTheme,
      darkTheme: myAppController.darkTheme,
      locale: Locale(Get.find<LanguageController>().appLocale),
      // themeMode: isSaveModeDark == true
      //     ? ThemeMode.dark
      //     : isSaveModeDark == false
      //         ? ThemeMode.light
      //         : ThemeMode.system,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      getPages: routes,
      initialRoute: '/',
      builder: (context, child) {
        return ShowCaseWidget(
          builder: Builder(
            builder: (context) => FlutterSmartDialog(child: child),
          ),
        );
      },
    );
  }
}
