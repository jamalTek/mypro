import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';

class NoRemindersW extends StatelessWidget {
  const NoRemindersW({
    super.key,
    this.onPress,
    this.isThereOtherDays = false,
  });
  final void Function()? onPress;
  final bool isThereOtherDays;

  @override
  Widget build(BuildContext context) {
    consoleLog(Get.find<HomeController>().isThereOtherDays);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        BasicSvg(
          Assets.assetsIconsReminder,
          width: kDeviceWidth * 0.2,
        ),
        generalBox,
        TranslatedText(
          Get.find<HomeController>().isThereOtherDays
              ? 'No notifications are scheduled today'
              : 'No reminders',
          style: 'grey16',
        ),
        generalBox,
        CupertinoButton(
          onPressed: onPress,
          padding: EdgeInsets.zero,
          minSize: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                CupertinoIcons.add,
                color: MerathColors.primary,
              ),
              generalSmallBox,
              const TranslatedText(
                'Add new reminder',
                style: 'primary18',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
