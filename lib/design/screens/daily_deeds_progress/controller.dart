import '../../../general_exports.dart';
import '../../widgets/dialogs/info_dialog.dart';
import 'sheets.dart';

class DailyDeedProgressController extends GetxController {
  late Map item;
  dynamic progressData;
  Map daysData = {};
  num totalProgress = 0;

  @override
  void onInit() {
    super.onInit();
    item = Get.arguments;
    consoleLog(item);
    getData();
  }

  void getData() {
    startLoading();
    if (userController.userData != null) {
      ApiRequest(
        path: apiHabitsProgress,
        method: getMethod,
      ).request(
        onSuccess: (data, response) {
          progressData = (data as List)
              .where((element) => element['user_habbit_id'] == item[kId])
              .toList();
          setData();
          dismissLoading();
          update();
        },
      );
    } else {
      final LocalStorage storage = Get.find<LocalStorage>();
      final List habitProgress = storage.read(kHabitsProgress) ?? [];
      progressData = (habitProgress)
          .where((element) =>
              element['user_habbit_id'] == (item[kId] ?? item[kUserHabitId]))
          .toList();
      setData();
      dismissLoading();
      update();
    }
  }

  void onAddProgress() {
    Get.bottomSheet(
      item[kHabitType] == kMeasurable
          ? AddMeasurableSheet(
              unit: item[kUnit],
              onPress: (v) {
                if (v.isEmpty) {
                  return;
                }
                addProgress(
                  value: int.tryParse(v) ?? 0,
                );
              },
            )
          : AddNotMeasurableSheet(
              onYes: () {
                addProgress(isDone: true);
              },
              onNo: () {
                addProgress(isDone: false);
              },
            ),
      isScrollControlled: true,
    );
  }

  void addProgress({int? value, bool? isDone}) {
    startLoading();
    final Map prog = {
      kUserHabitId: item[kId],
      kProgressValue: value,
      kIsHabitAccomplished: isDone,
      kActionDateTime: apiDayTimeFormate(DateTime.now()),
    };
    if (userController.userData != null) {
      ApiRequest(
        path: apiHabitsProgress,
        method: postMethod,
        body: [
          prog,
        ],
      ).request(
        onSuccess: (data, response) {
          dismissLoading();
          Get.back();
          Get.dialog(successDialog);
        },
      );
    } else {
      final LocalStorage storage = Get.find<LocalStorage>();
      final List habitProgress = storage.read(kHabitsProgress) ?? [];
      habitProgress.add(prog);
      storage.write(kHabitsProgress, habitProgress);
      dismissLoading();
      Get.back();
      Get.dialog(successDialog);
    }
  }

  void setData() {
    for (dynamic item in progressData) {
      if (item[kProgressValue] != null) {
        totalProgress =
            totalProgress + int.parse(item[kProgressValue].toString());
      }
      if (item[kActionDateTime] != null) {
        daysData[item[kActionDateTime]] = item;
      }
    }

    consoleLog(daysData);
  }

  double getPercentage() {
    if (item[kGoalNumber] == null) {
      return 0;
    }
    if (totalProgress / int.parse(item[kGoalNumber]) > 1) {
      return 1;
    } else {
      return totalProgress / int.parse(item[kGoalNumber]);
    }
  }
}
