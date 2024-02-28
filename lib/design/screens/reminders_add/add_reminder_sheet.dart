import 'package:flutter/cupertino.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import '../../../general_exports.dart';

class ReminderSettingsSheet extends StatelessWidget {
  const ReminderSettingsSheet({
    super.key,
    required this.reminder,
  });
  final Map reminder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (AddReminderController controller) {
      return Container(
        decoration: cardDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(horizontalSpacing),
          ),
        ),
        padding: generalPadding,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TranslatedText(
                    'Reminder settings',
                    style: textStyles['black16mid'],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration:
                          circleDecoration(color: MerathColors.shapeBackground),
                      padding: EdgeInsets.all(horizontalSpacing / 4),
                      child: Icon(
                        CupertinoIcons.xmark,
                        size: horizontalSpacing * 0.8,
                      ),
                    ),
                  ),
                ],
              ),
              generalBox,
              SizedBox(
                height: verticalSpacing * 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TranslatedText('Reminder sound'),
                    if (controller.isLoadingSound)
                      const CircularProgressIndicator.adaptive()
                    else
                      CupertinoButton(
                          padding: EdgeInsets.symmetric(
                              vertical: verticalSpacing / 2),
                          minSize: 0,
                          onPressed: () {
                            controller.playSound(reminder[kSound]);
                          },
                          child: const Icon(CupertinoIcons.speaker_2_fill)),
                  ],
                ),
              ),
              const Divider(),
              generalBox,
              const TranslatedText('Reminder time'),
              generalSmallBox,
              Container(
                decoration: cardDecoration(color: MerathColors.shapeBackground),
                height: kDeviceHeight * 0.2,
                child: true
                    ? CupertinoDatePicker(
                        onDateTimeChanged: controller.updateSelectedTime,
                        mode: CupertinoDatePickerMode.time,
                      )
                    : TimePickerSpinner(
                        time: controller.selectTime,
                        is24HourMode: false,
                        normalTextStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                        highlightedTextStyle: const TextStyle(
                          fontSize: 20,
                          color: MerathColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                        spacing: 50,
                        itemHeight: kDeviceHeight * 0.06,
                        onTimeChange: controller.updateSelectedTime,
                      ),
              ),
              const Divider(),
              generalBox,
              const TranslatedText('Reminder days'),
              generalSmallBox,
              Wrap(
                spacing: horizontalSpacing / 2,
                runSpacing: verticalSpacing / 2,
                children: List.generate(
                  controller.availableDays.length,
                  (index) {
                    final Map item = controller.availableDays[index];
                    final bool isSelected = item[kIsSelected];
                    consoleLog(item);
                    return GestureDetector(
                      onTap: () {
                        controller.toggleDat(item);
                      },
                      child: Container(
                        decoration: cardDecoration(
                          color: isSelected
                              ? MerathColors.accent
                              : MerathColors.accent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(
                            horizontalSpacing / 3,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: verticalSpacing / 2,
                          horizontal: horizontalSpacing / 2,
                        ),
                        child: TranslatedText(
                          dayFormat(item[kDate]),
                          style: textStyles[isSelected ? 'white14' : 'black14'],
                        ),
                      ),
                    );
                  },
                ),
              ),
              generalBox,
              generalBox,
              FullWidthButton(
                text: 'Add reminder',
                onPress: () {
                  controller.addReminder(reminder);
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
