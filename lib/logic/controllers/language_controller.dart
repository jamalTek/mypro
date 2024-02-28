import '../../general_exports.dart';

class LanguageController extends GetxController {
  //String appLocale = window.locale.toString().split('_')[0];
  String appLocale = 'ar';
  LocalStorage localStorage = LocalStorage();
  Map translations = {};
  List languages = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    final String? languageCode = await localStorage.read(kLanguageKey);
    appLocale = languageCode ?? appLocale;
    consoleLog('\x1B[33m App Language: $appLocale');
    Get.updateLocale(Locale(appLocale));
    update();
  }

  void changeLanguage(String selectedLanguage,
      {Function()? onLanguageUpdated}) {
    appLocale = selectedLanguage;
    localStorage.write(kLanguageKey, appLocale);
    Get.updateLocale(Locale(appLocale))
        .then((dynamic value) => onLanguageUpdated!());
    update();
  }

  void storeTranslations(Map data) {
    translations = data;
    localStorage.write(kTranslations, translations);
  }

  void storeLanguageKey(String selectedLanguage) {
    localStorage.write(kLanguageKey, selectedLanguage);
  }

  void updateTranslations() {
    ApiRequest(
      path: 'translations',
      method: getMethod,
    ).request(
      onSuccess: (data, response) {
        final List<dynamic> d = data;
        final Map? item = d.firstWhereOrNull(
            (element) => element.keys.toList()[0] == appLocale);
        consoleLog(item);
        storeTranslations(item?[appLocale] ?? data[0]);
        Future.delayed(0.seconds).then((value) => Get.forceAppUpdate());
        Get.find<MainController>().setScreens();
      },
    );
  }
}
