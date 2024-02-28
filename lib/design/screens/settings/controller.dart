import '../../../general_exports.dart';
import '../../../logic/controllers/notification_controller.dart';

class SettingsController extends GetxController {
  List<Map> items = [];
  @override
  void onInit() {
    super.onInit();
    initItems();
  }

  String getLanguageName({String? local}) {
    final LanguageController languageController =
        Get.find<LanguageController>();
    final String myLocal = local ?? languageController.appLocale;
    return (languageController.languages
            .firstWhereOrNull((element) => element[kValue] == myLocal) ??
        {'label': 'Default'})['label'];
  }

  void initItems() {
    items = [
      {
        kTitle: 'Reminders',
        kIsSelected: Get.find<NotificationController>().all.isNotEmpty,
        kOnPress: (bool v) {
          final NotificationController notificationController =
              Get.find<NotificationController>();
          if (v) {
            notificationController.reActiveAll();
          } else {
            notificationController.cancelAll();
          }
          items[0][kIsSelected] = v;
          update();
        },
      },
      {
        kTitle: 'Receive notification for daily habits',
        kIsSelected: false,
        kOnPress: (bool v) {},
      },
      // {
      //   kTitle: 'Active children notification',
      //   kIsSelected: false,
      //   kOnPress: (bool v) {},
      // },
      {
        kTitle: 'Dark mode',
        kIsSelected: Get.isDarkMode,
        kOnPress: (bool v) {
          Get.find<MyAppController>().changeTheme();
          items.firstWhere(
                  (element) => element[kTitle] == 'Dark mode')[kIsSelected] =
              !Get.isDarkMode;
          Future.delayed(1.seconds).then((value) => Get.forceAppUpdate());
          update();
        },
      },
    ];
  }
}
