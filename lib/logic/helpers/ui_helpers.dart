import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

bool isDarkMode(context) {
  isDark = Theme.of(context).brightness == Brightness.dark;

  if (box.read(kIsDark) != isDark) {
    consoleLog('ThemeChanged to: $isDark');
    box.write(kIsDark, isDark);
    Get.find<MerathColors>()
        .updateColor(isDark ? ThemeMode.dark : ThemeMode.light);
    textStyles = MerathTextStyles().styles;
  }
  return isDark;
}

int numberToShow(num number) {
  return number.toInt();
}

String timeToShow(int hour, int minute) {
  bool isAm = true;
  final String minuteInString =
      minute.toString().length == 1 ? '0$minute' : '$minute';
  if (hour > 12) {
    hour = hour - 12;
    isAm = false;
  }
  final String hourIntString = hour.toString().length == 1 ? '0$hour' : '$hour';

  return '$hourIntString:$minuteInString ${isAm ? 'AM' : 'PM'}';
}

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<bool> checkInternet() async {
  try {
    final List<InternetAddress> response =
        await InternetAddress.lookup('www.google.com');

    if (response.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException {
    return false;
  }
}

Widget getBackground(
  BuildContext context, {
  bool superLight = true,
}) {
  return SvgPicture.asset(
    isDarkMode(context)
        ? Assets.assetsIconsBackgroundDark
        : superLight
            ? Assets.assetsIconsSuperLight
            : Assets.assetsIconsBackgroundLight,
    fit: BoxFit.cover,
  );
}

String stripHtmlIfNeeded(String text) {
  return text.replaceAll(RegExp('<[^>]*>|&[^;]+;'), ' ');
}

void showMessage({
  String? description,
  String? type,
  bool withBackground = true,
  int duration = 3,
}) {
  Get.snackbar(
    '',
    '',
    titleText: const TranslatedText(
      'Alert',
      style: 'black18semi',
      //  description!,
    ),
    messageText: TranslatedText(
      description!,
      style: 'black14',
    ),
    backgroundColor: withBackground ? Colors.white60 : null,
    barBlur: 2,
    duration: Duration(seconds: duration),
  );
}

/// show popup
void showPopUp({Widget? child}) {
  Get.dialog(
    child!,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
  );
}

void dismissLoading() {
  SmartDialog.dismiss();
}

void startLoading() {
  SmartDialog.showLoading(
    builder: (context) {
      return GestureDetector(
        onDoubleTap: () {
          dismissLoading();
        },
        child: Container(
          decoration: cardDecoration(),
          width: kDeviceWidth * 0.35,
          height: kDeviceWidth * 0.35,
          child: const LoadingWidget(),
        ),
      );
    },
  );
}

String remainingTime(int hour, int minute) {
  final int remainingHour = hour - DateTime.now().hour;
  final int remainingMinute = minute - DateTime.now().minute;
  String hourToShow = '$remainingHour';
  String minuteToShow = '$remainingMinute';
  if (remainingHour.toString().length < 2) {
    hourToShow = '0$hourToShow';
  }
  if (remainingMinute.toString().length < 2) {
    minuteToShow = '0$minuteToShow';
  }
  return '$hourToShow:$minuteToShow';
}

void consoleLog(dynamic value, {String key = 'value'}) {
  if (viewLog) {
    developer.log('📔:\x1B[32m ******** Log $key **********:📔');
    developer.log('\x1B[35m $key :\x1B[37m $value');
    developer.log('📓:\x1B[32m  *************** END **************:📓');
  }
}

String getWord(String key) {
  //final LanguageController languageController = Get.find<LanguageController>();
  return Get.find<LanguageController>().translations[key] ?? key;
}

Color getLightColoredBG(BuildContext context) {
  return isDarkMode(context)
      ? MerathColors.shapeBackground
      : MerathColors.lightGreen;
}
