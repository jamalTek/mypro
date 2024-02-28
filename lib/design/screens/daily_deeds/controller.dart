import 'package:showcaseview/showcaseview.dart';

import '../../../general_exports.dart';

class DailyDeedsController extends GetxController {
  GlobalKey showcaseAddDailyDeed = GlobalKey();
  Color color = MerathColors.red;
  List dailyDeeds = [
    // {
    //   kTitle: 'title',
    //   kSubtitle: kSubtitle,
    //   kPageCount: null,
    //   kRemindPer: 'remind per 3 days',
    //   kReminderTime: '2:30',
    //   kReminderNumber: '3',
    // },
  ];

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
    if (box.read(kShowedDailyDeeds) == null) {
      ShowCaseWidget.of(Get.context!).startShowCase([showcaseAddDailyDeed]);
      box.write(kShowedDailyDeeds, true);
    }
  }

  void deleteItem(Map item) {
    dailyDeeds.remove(item);
    if (userController.userData != null) {
      ApiRequest(
        path: '$apiHabits/${item[kId]}',
        method: deleteMethod,
      ).request(
        onSuccess: (data, response) {
          dismissLoading();
          Get.back();
          // Get.dialog(successDialog);
          Get.find<DailyDeedsController>().getData();
        },
      );
    } else {
      dailyDeeds.remove(item);
      update();
      box.write(kHabits, dailyDeeds);
    }
  }

  void getData() {
    startLoading();
    if (userController.userData != null) {
      ApiRequest(path: apiHabits, method: getMethod).request(
        onSuccess: (data, response) {
          dailyDeeds = data;
          update();
          dismissLoading();
        },
      );
    } else {
      final List habits = box.read(kHabits) ?? [];
      dailyDeeds = habits;
      update();
      dismissLoading();
    }
  }
}
