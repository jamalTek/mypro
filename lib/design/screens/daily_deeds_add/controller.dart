import 'package:showcaseview/showcaseview.dart';

import '../../../general_exports.dart';
import '../../../logic/controllers/notification_controller.dart';
import '../../widgets/dialogs/info_dialog.dart';

class AddDailyDeedController extends GetxController {
  List<String> types = ['measurable', 'not_measurable'];
  int selectedTypeIndex = 0;
  List<String> reminderFrequencyType = ['day', 'month'];
  int selectedFrequencyTypeIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController reminderNumberController = TextEditingController();
  DateTime selectedTime = DateTime.now();

  GlobalKey scType = GlobalKey();
  GlobalKey scTitle = GlobalKey();
  GlobalKey scUnit = GlobalKey();
  GlobalKey scGoal = GlobalKey();
  GlobalKey scReminderPerUnit = GlobalKey();
  GlobalKey scReminderNumber = GlobalKey();
  GlobalKey scTime = GlobalKey();
  GlobalKey scNote = GlobalKey();
  GlobalKey scAction = GlobalKey();

  bool isUdate = false;

  @override
  void onReady() {
    super.onReady();
    if (box.read(kShowedDailyDeedsScreen) == null) {
      ShowCaseWidget.of(Get.context!).startShowCase([
        scType,
        scTitle,
        scUnit,
        scGoal,
        scReminderPerUnit,
        scReminderNumber,
        scTime,
        scNote,
        scAction,
      ]);
      box.write(kShowedDailyDeedsScreen, true);
    }
    Map? item = Get.arguments;
    if (item != null) {
      isUdate = true;
      selectedTypeIndex = types.indexOf(item[kHabitType]);
      titleController.text = item[kTitle];
      unitController.text = item[kUnit];
      goalController.text = item[kGoalNumber];
      reminderNumberController.text = item[kReminderNumber];
      selectedFrequencyTypeIndex =
          reminderFrequencyType.indexOf(item[kReminderFrequencyType]);
      noteController.text = item[kNotes] ?? '';
      update();
    }
  }

  void selectTime() {
    Get.bottomSheet(
      TimeSelector(
        onChange: (time) {
          selectedTime = time;
          update();
        },
        initialTime: selectedTime,
      ),
      isScrollControlled: true,
    );
  }

  void selectType() {
    Get.bottomSheet(
      PickFromPicker(
        initialIndex: selectedTypeIndex,
        list: types,
        onChange: (index) {
          selectedTypeIndex = index;
          update();
        },
      ),
      isScrollControlled: true,
    );
  }

  void selectFrequency() {
    Get.bottomSheet(
      PickFromPicker(
        initialIndex: selectedFrequencyTypeIndex,
        list: reminderFrequencyType,
        onChange: (index) {
          selectedFrequencyTypeIndex = index;
          update();
        },
      ),
      isScrollControlled: true,
    );
  }

  Future<void> addDeed() async {
    if (titleController.text.isEmpty ||
        unitController.text.isEmpty ||
        goalController.text.isEmpty ||
        reminderNumberController.text.isEmpty) {
      showMessage(description: getWord('Please enter all required fields'));
      return;
    }
    startLoading();
    int reminderNo = int.parse(reminderNumberController.text);
    int valueToAdd = reminderNo;
    if (reminderFrequencyType[selectedFrequencyTypeIndex] == 'day') {
      for (int i = 0; i < 29; i++) {
        consoleLog('$i:$valueToAdd');
        final DateTime date = DateTime.now().add(
          Duration(days: valueToAdd),
        );
        Get.find<NotificationController>().showInSpecificDate(
            DateTime(
              date.year,
              date.month,
              date.day,
              selectedTime.hour,
              selectedTime.minute,
            ),
            titleController.text);
        valueToAdd = valueToAdd + reminderNo;
        await Future.delayed(0.1.seconds);
      }
      // final List<Day> days = [];
      // for (int i = 7; i > reminderNo; i--) {
      //   days.add(
      //     getDayByTitle(
      //       dayFormat(
      //         DateTime.now().add(Duration(days: i)),
      //       ),
      //     ),
      //   );
      // }

      // Get.find<NotificationController>().scheduleWeeklyNotifications(
      //   days: [getDayByTitle(dayFormat(DateTime.now()))],
      //   title: titleController.text,
      //   body: titleController.text,
      //   time: nt.Time(selectedTime.hour, selectedTime.minute),
      // );
    } else {
      reminderNo = reminderNo * 30;
      int valueToAdd = reminderNo;
      for (int i = 0; i < 8; i++) {
        consoleLog('$i:$valueToAdd');
        Get.find<NotificationController>().showInSpecificDate(
            DateTime.now().add(
              Duration(days: valueToAdd),
            ),
            titleController.text);
        valueToAdd = valueToAdd + reminderNo;
      }
    }

    final List notifications = box.read(kNotifications) ?? [];

    final Map newItem = {
      kTitle: titleController.text,
      kSubtitle: titleController.text,
      kHour: selectedTime.hour,
      kMinute: selectedTime.minute,
      kType: types[selectedTypeIndex],
    };
    final int index = notifications.indexOf(
      notifications.firstWhereOrNull(
          (element) => element[kTitle] == titleController.text),
    );
    if (index == -1) {
      notifications.add(newItem);
    } else {
      notifications[index] = newItem;
    }
    box.write(kNotifications, notifications);

    final Map<String, dynamic> item = {
      kHabitType: types[selectedTypeIndex],
      kTitle: titleController.text,
      kUnit: unitController.text,
      kGoalNumber: goalController.text,
      kNotes: noteController.text,
      kHasReminder: true,
      kReminderFrequencyType: reminderFrequencyType[selectedFrequencyTypeIndex],
      kReminderNumber: reminderNumberController.text,
      kReminderTime: timeFormat24(selectedTime),
      kUserHabitId: DateTime.now().millisecondsSinceEpoch,
    };
    if (userController.userData != null) {
      ApiRequest(
        path: apiHabits,
        method: postMethod,
        body: item,
      ).request(
        onSuccess: (data, response) {
          dismissLoading();
          Get.back();
          Get.dialog(successDialog);
          Get.find<DailyDeedsController>().getData();
        },
      );
    } else {
      final LocalStorage storage = Get.find<LocalStorage>();
      final List habits = storage.read(kHabits) ?? [];
      habits.add(item);
      storage.write(kHabits, habits);
      dismissLoading();
      Get.back();
      Get.dialog(successDialog);
      Get.find<DailyDeedsController>().getData();
    }
  }

  Future<void> delete(Map item) async {
    final DailyDeedsController controller = Get.find<DailyDeedsController>();
    final NotificationController notiController =
        Get.find<NotificationController>();
    await notiController.cancelByTitle(item[kTitle]);
    if (userController.userData != null) {
      ApiRequest(
        path: '$apiHabits/${item[kId]}',
        method: deleteMethod,
        body: item,
      ).request(
        onSuccess: (data, response) {
          // dismissLoading();
          //Get.back();
          // Get.dialog(successDialog);
          //Get.find<DailyDeedsController>().getData();
        },
      );
    } else {
      controller.dailyDeeds.remove(item);
      controller.update();
      box.write(kHabits, controller.dailyDeeds);
    }
  }

  Future<void> updateItem() async {
    final Map<String, dynamic> item = Get.arguments;
    await delete(item);
    addDeed();
  }
}
