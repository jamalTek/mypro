import 'package:showcaseview/showcaseview.dart';

import '../../../general_exports.dart';

class MainController extends GetxController with WidgetsBindingObserver {
  GlobalKey showCaseVOfDeedsKey = GlobalKey();
  GlobalKey showCaseDailyDeedsKey = GlobalKey();
  GlobalKey showCaseRemindersKey = GlobalKey();
  List<Map> screens = [
    {
      kName: getWord('Home'),
      kWidget: const Home(),
      kIcon: Assets.assetsIconsHome,
    },
    {
      kName: getWord('Virtues of deeds'),
      kWidget: const VirtuesOfDeeds(),
      kIcon: Assets.assetsIconsIslamVectors,
    },
    {
      kName: getWord('Daily deeds'),
      kWidget: const DailyDeeds(),
      kIcon: Assets.assetsIconsPraying,
    },
    {
      kName: getWord('Alerts'),
      kWidget: const Reminders(),
      kIcon: Assets.assetsIconsReminder,
    },
  ];
  int selectedScreenIndex = 0;

  List homeSlider = [];

  void updateSelectedScreen(int index) {
    selectedScreenIndex = index;
    update();
    if (index == 1) {
      if (Get.isRegistered<VirtuesOfDeedsController>()) {
        Get.find<VirtuesOfDeedsController>().getContents();
      }
    }
  }

  void setScreens() {
    screens = [
      {
        kName: getWord('Home'),
        kWidget: const Home(),
        kIcon: Assets.assetsIconsHome,
      },
      {
        kName: getWord('Virtues of deeds'),
        kWidget: const VirtuesOfDeeds(),
        kIcon: Assets.assetsIconsIslamVectors,
      },
      {
        kName: getWord('Daily deeds'),
        kWidget: const DailyDeeds(),
        kIcon: Assets.assetsIconsPraying,
      },
      {
        kName: getWord('Alerts'),
        kWidget: const Reminders(),
        kIcon: Assets.assetsIconsReminder,
      },
    ];
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    getSliders();
  }

  @override
  void onReady() {
    super.onReady();
    if (box.read(kShowedMainScreenCase) == null) {
      ShowCaseWidget.of(Get.context!).startShowCase(
          [showCaseVOfDeedsKey, showCaseDailyDeedsKey, showCaseRemindersKey]);
      box.write(kShowedMainScreenCase, true);
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      isDarkMode(Get.context);
      update();
    }
  }

  void getSliders() {
    //consoleLog('Main getting home sliders');
    // ApiRequest(path: apiSliders, method: getMethod).request(
    //   onSuccess: (data, response) {
    //     homeSlider = data;

    //     update();
    //   },
    // );
  }
}
