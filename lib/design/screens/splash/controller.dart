import '../../../general_exports.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    // Future.delayed(2.seconds).then(
    //   (value) => Get.offAllNamed(routeLogin),
    // );
    getLanguagesList();
    getLanguages();
  }

  void getLanguagesList() {
    ApiRequest(path: 'languages', method: getMethod).request(
      onSuccess: (data, response) {
        Get.find<LanguageController>().languages = data;
      },
    );
  }

  void getLanguages() {
    ApiRequest(
      path: 'translations',
      method: getMethod,
    ).request(
      onSuccess: (data, response) {
        if (userController.userData != null ||
            (box.read(kIsSkipped) ?? false)) {
          Get.offAllNamed(routeMain);
        } else {
          Get.offAllNamed(routeLogin);
        }
        final LanguageController languageController =
            Get.find<LanguageController>();
        final List<dynamic> d = data;
        final Map? item = d.firstWhereOrNull((element) =>
            element.keys.toList()[0] == languageController.appLocale);
        consoleLog(item);
        languageController
            .storeTranslations(item?[languageController.appLocale] ?? data[0]);
      },
    );
  }
}
