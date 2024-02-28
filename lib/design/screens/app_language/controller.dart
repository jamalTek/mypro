import '../../../general_exports.dart';

class AppLanguageScreenController extends GetxController {
  List languages = Get.find<LanguageController>().languages;
  LanguageController languageController = Get.find<LanguageController>();
  int selectedLanguageIndex = 0;

  void updateLanguage(int index) {
    selectedLanguageIndex = index;
    update();
  }

  void changeLanguage(String local) {
    languageController.changeLanguage(
      local,
      onLanguageUpdated: () {
        languageController.updateTranslations();
      },
    );
    update();
  }

  @override
  void onInit() {
    super.onInit();
    final Map selectedLanguage = languages.firstWhereOrNull(
            (element) => element[kValue] == languageController.appLocale) ??
        {
          'value': 'ar',
          'label': 'عربي',
        };
    updateLanguage(languages.indexOf(selectedLanguage));
  }
}
