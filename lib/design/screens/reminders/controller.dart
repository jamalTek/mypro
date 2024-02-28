import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as nt;

import '../../../general_exports.dart';
import '../../../logic/controllers/notification_controller.dart';
import '../../../logic/helpers/general.dart';

class ReminderController extends GetxController {
  int selectedCategory = 0;
  List categories = [
    {
      kIcon: Assets.assetsIconsReminder,
      kTitle: 'General reminders',
      kKey: kGeneraReminders,
    },
    {
      kIcon: Assets.assetsIconsKid,
      kTitle: 'Children reminders',
      kKey: kKidsReminder,
    },
  ];
  List reminders = [];
  List remindersToView = [];
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void updateSelectedCategory(int index) {
    selectedCategory = index;
    updateListToView();
    update();
  }

  List updateListToView() {
    remindersToView = reminders
        .where(
            (element) => element[kType] == categories[selectedCategory][kKey])
        .toList();
    update();
    consoleLog(remindersToView);
    return remindersToView;
  }

  void onSeatch(v) {
    remindersToView = reminders
        .where((element) =>
            element[kType] == categories[selectedCategory][kKey] &&
            (element[kTitle] as String)
                .toLowerCase()
                .contains(v.toString().toLowerCase()))
        .toList();
    update();
    consoleLog(remindersToView);
  }

  void getData() {
    //startLoading();
    reminders = box.read(kNotifications) ?? [];
    dismissLoading();
    updateListToView();
  }

  void switchNotification(item) {
    final bool isActive = Get.find<NotificationController>()
            .all
            .firstWhereOrNull((element) => element.title == item[kTitle]) !=
        null;
    if (!isActive) {
      final List<Day> days = [];
      for (String dayName in item[kDays]) {
        days.add(getDayByTitle(dayName));
      }
      Get.find<NotificationController>().scheduleWeeklyNotifications(
        days: days,
        title: item[kTitle],
        body: item[kTitle],
        time: nt.Time(item[kHour], item[kMinute]),
        url: item[kSound],
      );
    } else {
      Get.find<NotificationController>().cancelByTitle(item[kTitle]);
    }
    update();
  }
}
