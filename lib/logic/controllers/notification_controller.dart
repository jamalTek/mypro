// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../general_exports.dart';
import '../helpers/general.dart';
import '../helpers/network.dart';

class NotificationController extends GetxController {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late AndroidInitializationSettings initializationSettingsAndroid;
  late DarwinInitializationSettings darwinInitializationSettings;
  late InitializationSettings initializationSettings;
  List<PendingNotificationRequest> all = [];

  @override
  void onInit() {
    super.onInit();
    getTimeZone();

    initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');
    darwinInitializationSettings = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: darwinInitializationSettings,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: (payload) {},
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    getAll();
  }

  Future<void> getTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future<void> onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }

  Future<bool> requestIosNotificationPermission() async {
    final bool? result;
    if (Platform.isIOS) {
      result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else {
      result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    }
    return result ?? false;
  }

  tz.TZDateTime _nextInstanceOfDay(Day day, Time time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    consoleLog(time.hour);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, time.hour, time.minute, now.second + 5);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    while (scheduledDate.weekday != day.value) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    consoleLog(scheduledDate);
    return scheduledDate;
  }

  Future<void> scheduleWeeklyNotifications({
    required List<Day> days,
    required String title,
    required String body,
    required Time time,
    String? url,
  }) async {
    Directory? dir;
    if (Platform.isAndroid) {
      dir = await getExternalStorageDirectory() ?? await getLibraryDirectory();
    } else {
      dir = await getLibraryDirectory();
    }
    final List<PendingNotificationRequest> all = await getAll();

    for (PendingNotificationRequest notificationRequest in all) {
      if (notificationRequest.title == title) {
        cancelById(notificationRequest.id);
      }
    }

    final String fileName = url?.split('/').last ?? title;
    final String filePath = '${dir.path}/Sounds/$fileName';
    final File file = File(filePath);
    final bool isFileExits = await file.exists();
    if (!isFileExits && url != null) {
      await downloadFile(url, filePath);
    }

    consoleLog('Pushing for $days');
    consoleLog('File: $isFileExits ${file.path}');

    for (Day day in days) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        getNotificationId(day, time, title),
        title,
        body,
        _nextInstanceOfDay(day, time),
        NotificationDetails(
          iOS: url != null
              ? DarwinNotificationDetails(
                  sound: fileName,
                  presentSound: true,
                )
              : null,
          android: AndroidNotificationDetails(
            getNotificationId(day, time, title).toString(),
            title,
            sound: url != null ? UriAndroidNotificationSound(filePath) : null,
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        // androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
    getAll();
  }

  int getNotificationId(Day day, Time time, String title) {
    return (day.value * 10000 + time.hour * 100 + time.minute) +
        generateUniqueValue(title);
  }

  int generateUniqueValue(String input) {
    int result = 0;
    for (int i = 0; i < input.length; i++) {
      result += input.codeUnitAt(i);
    }
    return result;
  }

  Future<void> cancelNotification(
      List<Day> days, Time time, String title) async {
    for (Day day in days) {
      final id = getNotificationId(day, time, title);
      await flutterLocalNotificationsPlugin.cancel(id);
    }
    getAll();
  }

  void cancelById(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
    getAll();
  }

  Future<void> cancelByTitle(String title) async {
    final List<PendingNotificationRequest> all = await getAll();
    for (PendingNotificationRequest i in all) {
      if (i.title == title) {
        flutterLocalNotificationsPlugin.cancel(i.id);
      }
    }
    getAll();
  }

  void cancelAll() {
    flutterLocalNotificationsPlugin.cancelAll();
    getAll();
  }

  Future<void> reActiveAll() async {
    for (Map i in box.read(kNotifications) ?? []) {
      final List<Day> days = [];
      for (String j in i[kDays]) {
        days.add(getDayByTitle(j));
      }
      await scheduleWeeklyNotifications(
        days: days,
        title: i[kTitle],
        body: i[kTitle],
        time: Time(
          i[kHour],
          i[kMinute],
        ),
      );
    }
  }

  Future<List<PendingNotificationRequest>> getAll() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    all = pendingNotificationRequests;
    if (Get.isRegistered<ReminderController>()) {
      Get.find<ReminderController>().update();
    }
    return pendingNotificationRequests;
  }

  Future<void> showNow() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      99,
      'fast title',
      'fast body',
      tz.TZDateTime.now(tz.local).add(
        const Duration(seconds: 1),
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> showInSpecificDate(
    DateTime dateTime,
    String title,
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      generateUniqueValue(DateTime.now()
          .add(Duration(microseconds: Random().nextInt(999)))
          .microsecondsSinceEpoch
          .toString()),
      title,
      title,
      tz.TZDateTime.parse(
        tz.local,
        apiDayTimeFormate(dateTime),
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}

enum Day {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday;

  int get value {
    return index + 1; // Monday is 1, Sunday is 7 in Dart's DateTime
  }
}
