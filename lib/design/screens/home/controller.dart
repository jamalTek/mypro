import 'package:showcaseview/showcaseview.dart';

import '../../../general_exports.dart';

class HomeController extends GetxController {
  int currentSliderIndex = 0;
  List<String> images = [testImage, testImage, testImage, testImage];
  List<dynamic> slider = [];
  GlobalKey reminderShowCase = GlobalKey();
  GlobalKey reminderQuickAcceessCase = GlobalKey();

  List<Map> fastAccess = [
    {
      kTitle: 'Prophet Biography',
      kOnPress: () {
        Get.toNamed(routeProphetBiography);
      },
    },
    {
      kTitle: 'Favorite',
      kOnPress: () {
        Get.toNamed(routeFavorites);
        //  Get.find<MainController>().updateSelectedScreen(1);
      },
    },
    {
      kTitle: 'Masbaha',
      kOnPress: () {
        Get.toNamed(routeMasbaha);
      },
    },
  ];

  List reminders = Get.find<ReminderController>().reminders;
  List reminderToShow = [];
  bool isThereOtherDays = false;
  @override
  void onInit() {
    super.onInit();
    getData();
    updateReminders();
  }

  @override
  void onReady() {
    super.onReady();
    if (box.read(kShowedHomeCase) == null) {
      ShowCaseWidget.of(Get.context!)
          .startShowCase([reminderQuickAcceessCase, reminderShowCase]);
      box.write(kShowedHomeCase, true);
    }
  }

  void updateReminders() {
    reminders = Get.find<ReminderController>().reminders;
    reminderToShow = reminders.where((element) {
      if (element[kDays] != null) {
        isThereOtherDays = true;
        update();
        return element[kDays].contains(
              dayFormat(
                DateTime.now(),
              ),
            ) &&
            DateTime.now().hour <= element[kHour] &&
            DateTime.now().minute <= element[kMinute];
      } else {
        return false;
      }
    }).toList();
    update();
  }

  void getData() {
    getSliders();
  }

  void onPageChange(index, uselessInfo) {
    currentSliderIndex = index;
    updateReminders();
    update();
  }

  void onMenuPress() {
    Get.toNamed(routeAccount);
  }

  void getSliders() {
    final MainController mainController = Get.find<MainController>();
    if (mainController.homeSlider.isEmpty) {
      consoleLog('Main getting home sliders');
      ApiRequest(path: apiSliders, method: getMethod).request(
        onSuccess: (data, response) {
          slider = data;
          update();
        },
      );
    } else {
      slider = mainController.homeSlider;
    }
  }
}
