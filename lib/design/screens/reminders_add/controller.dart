import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as nt;

import '../../../general_exports.dart';
import '../../../logic/controllers/notification_controller.dart';
import 'add_reminder_sheet.dart';

class AddReminderController extends GetxController {
  int selectedCategory = Get.find<ReminderController>().selectedCategory;
  NotificationController notificationController =
      Get.find<NotificationController>();
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
  final List weekdays = daysInRange(
    DateTime(2023, 06, 18),
    DateTime(2023, 06, 24),
  ).toList();
  List availableDays = [];
  bool activeSound = false;
  DateTime selectTime = DateTime.now();
  Map? lastSelectedReminder;

// *** Functions Sections ***

  @override
  void onInit() {
    super.onInit();
    consoleLog(weekdays);
    availableDays = weekdays
        .map((e) => {
              kIsSelected: false,
              kDate: e,
            })
        .toList();
    getData();
    consoleLog(weekdays);
  }

  void getData() {
    startLoading();
    ApiRequest(path: apiReminders, method: getMethod).request(
      onSuccess: (data, response) {
        dismissLoading();
        reminders = data;

        updateListToView();
      },
    );
  }

  bool isLoadingSound = false;
  Future<void> playSound(String url) async {
    isLoadingSound = true;
    update();
    await AudioPlayer().play(UrlSource(url));
    isLoadingSound = false;
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

  void updateSelectedCategory(int index) {
    selectedCategory = index;
    updateListToView();
  }

  // void soundToggle(v) {
  //   activeSound = v;
  //   update();
  // }

  void updateSelectedTime(DateTime time) {
    selectTime = time;
    HapticFeedback.heavyImpact();
    update();
  }

  void toggleDat(Map day) {
    day[kIsSelected] = !day[kIsSelected];
    update();
  }

  Future<void> addReminder(dynamic item) async {
    final List days = availableDays.where((e) => e[kIsSelected]).toList();
    final List<Day> daysAsDays = days
        .map((e) => Day.values
            .firstWhere((element) => e[kDate].weekday == element.value))
        .toList();
    if (days.isEmpty) {
      showMessage(
        description: getWord('Select days to show'),
      );
      return;
    }

    notificationController.scheduleWeeklyNotifications(
      days: daysAsDays,
      title: item[kTitle],
      body: item[kTitle],
      time: nt.Time(selectTime.hour, selectTime.minute),
      url: item[kSound],
    );
    final List notifications = box.read(kNotifications) ?? [];
    final List<String> daysAsString = [];
    for (var element in daysAsDays) {
      daysAsString.add(element.name);
    }
    final Map newItem = {
      kDays: daysAsString,
      kTitle: item[kTitle],
      kSubtitle: item[kTitle],
      kHour: selectTime.hour,
      kMinute: selectTime.minute,
      kSound: item[kSound],
      kType: item[kType],
    };
    final int index = notifications.indexOf(notifications
        .firstWhereOrNull((element) => element[kTitle] == item[kTitle]));
    if (index == -1) {
      notifications.add(newItem);
    } else {
      notifications[index] = newItem;
    }
    box.write(kNotifications, notifications);
    Get.find<ReminderController>().reminders = box.read(kNotifications);
    Get.find<ReminderController>().updateListToView();
    Get.back();
    Get.find<HomeController>().updateReminders();
    showMessage(description: getWord('Added successfully'));
  }

  void showReminderSetting(Map reminder) {
    availableDays = weekdays
        .map((e) => {
              kIsSelected: false,
              kDate: e,
            })
        .toList();
    availableDays.removeWhere(
        (element) => !lastSelectedReminder![kAvailableDaysForReminder].contains(
              dayFormat(element[kDate]).toString().toUpperCase(),
            ));
    Get.bottomSheet(
      ReminderSettingsSheet(
        reminder: reminder,
      ),
      isScrollControlled: true,
      enableDrag: false,
    );
  }

  Future<void> viewAll() async {
    final List<nt.PendingNotificationRequest> all =
        await notificationController.getAll();
    Get.defaultDialog(
        content: Column(
      children: [...all.map((e) => Text(e.title ?? ''))],
    ));
  }
}
