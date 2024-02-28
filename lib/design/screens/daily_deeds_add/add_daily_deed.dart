import 'package:flutter/cupertino.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../general_exports.dart';

class AddDailyDeed extends StatelessWidget {
  const AddDailyDeed({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDailyDeedController>(
      init: AddDailyDeedController(),
      builder: (AddDailyDeedController controller) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              hideKeyboard();
            },
            child: Stack(
              children: [
                getBackground(context),
                Column(
                  children: [
                    const Header(
                      withBack: true,
                      title: 'Add daily deed',
                    ),
                    Expanded(
                      child: Container(
                        decoration: cardDecoration(),
                        margin: generalPadding,
                        padding: generalPadding,
                        width: kDeviceWidth,
                        child: ScrollWithExpanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TranslatedText(
                                'select type of deed',
                                style: textStyles['black12'],
                              ),
                              generalSmallBox,
                              SizedBox(
                                height: verticalSpacing * 2,
                                child: Showcase(
                                  key: controller.scType,
                                  description: getWord(
                                      'There are two types of work: measurable and non-measurable.\nThe type of measurable action can be answered by reciting two pages of the Qur’an.\nThe type of work that is not measurable can be answered with a yes or no answer, such as: Did you wake up early today?'),
                                  child: BorderRow(
                                    title: controller
                                        .types[controller.selectedTypeIndex],
                                    color: MerathColors.textColor,
                                    icon: CupertinoIcons.chevron_down,
                                    onPress: controller.selectType,
                                  ),
                                ),
                              ),
                              generalBox,
                              TranslatedText(
                                'deed title',
                                style: textStyles['black12'],
                              ),
                              generalSmallBox,
                              SizedBox(
                                height: verticalSpacing * 2,
                                child: Showcase(
                                  key: controller.scTitle,
                                  description: getWord(
                                    'The title of the work is the title of the thing you want to get used to. Example: waking up early',
                                  ),
                                  child: CTextInput(
                                    isSmall: true,
                                    hint: getWord('title'),
                                    controller: controller.titleController,
                                  ),
                                ),
                              ),
                              generalBox,
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TranslatedText(
                                          'Unit',
                                          style: textStyles['black12'],
                                        ),
                                        generalSmallBox,
                                        SizedBox(
                                          height: verticalSpacing * 2,
                                          child: Showcase(
                                            key: controller.scUnit,
                                            description: getWord(
                                              'The unit is used for measurable habits. Example: If the habit is to recite the Qur’an, the unit could be a page.',
                                            ),
                                            child: CTextInput(
                                              isSmall: true,
                                              hint: getWord('example - page'),
                                              controller:
                                                  controller.unitController,
                                            ),
                                          ),
                                        ),
                                        generalBox,
                                        TranslatedText(
                                          'reminder frequency',
                                          style: textStyles['black12'],
                                        ),
                                        generalSmallBox,
                                        SizedBox(
                                          height: verticalSpacing * 2,
                                          child: Showcase(
                                            key: controller.scReminderPerUnit,
                                            description: getWord(
                                                'You will receive alerts to remind you to perform the habit. The alert can be repeated on a daily or monthly basis.'),
                                            child: BorderRow(
                                              title: controller
                                                      .reminderFrequencyType[
                                                  controller
                                                      .selectedFrequencyTypeIndex],
                                              onPress:
                                                  controller.selectFrequency,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  generalBox,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TranslatedText(
                                          'goal',
                                          style: textStyles['black12'],
                                        ),
                                        generalSmallBox,
                                        SizedBox(
                                          height: verticalSpacing * 2,
                                          child: Showcase(
                                            key: controller.scGoal,
                                            description: getWord(
                                                'The goal is a number, so if the unit is a page and the goal is 4, then 4 pages is the goal.'),
                                            child: CTextInput(
                                              isSmall: true,
                                              hint: getWord('example 1 page'),
                                              inputType: TextInputType.number,
                                              controller:
                                                  controller.goalController,
                                            ),
                                          ),
                                        ),
                                        generalBox,
                                        TranslatedText(
                                          'remind every',
                                          style: textStyles['black12'],
                                        ),
                                        generalSmallBox,
                                        SizedBox(
                                          height: verticalSpacing * 2,
                                          child: Showcase(
                                            key: controller.scReminderNumber,
                                            description: getWord(
                                                'You can specify how many times you want the alerts to repeat daily or monthly. Example: Repeat the alert every 2 days.'),
                                            child: CTextInput(
                                              isSmall: true,
                                              hint: getWord('every 1 day'),
                                              inputType: TextInputType.number,
                                              controller: controller
                                                  .reminderNumberController,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              generalBox,
                              TranslatedText(
                                'time',
                                style: textStyles['black12'],
                              ),
                              generalSmallBox,
                              SizedBox(
                                height: verticalSpacing * 2,
                                child: Showcase(
                                  key: controller.scTime,
                                  description:
                                      getWord('You can set the reminder time.'),
                                  child: BorderRow(
                                    title: timeFormat(controller.selectedTime),
                                    color: MerathColors.primary,
                                    icon: CupertinoIcons.time,
                                    onPress: controller.selectTime,
                                  ),
                                ),
                              ),
                              generalBox,
                              TranslatedText(
                                'notes (optional)',
                                style: textStyles['black12'],
                              ),
                              generalSmallBox,
                              SizedBox(
                                height: kDeviceHeight * 0.2,
                                child: Showcase(
                                  key: controller.scNote,
                                  description: getWord(
                                      'You can place a note that will appear when you click on the alert.'),
                                  child: CTextInput(
                                    isSmall: true,
                                    hint: getWord('selected time'),
                                    controller: controller.noteController,
                                    minLines: 6,
                                    maxLines: 6,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: verticalSpacing * 3,
                                child: Showcase(
                                  key: controller.scAction,
                                  description: getWord(
                                      'When you click on Add Work, alerts will be scheduled according to the input.'),
                                  child: FullWidthButton(
                                    text: controller.isUdate
                                        ? 'Update'
                                        : 'Add deed',
                                    onPress: controller.isUdate
                                        ? controller.updateItem
                                        : controller.addDeed,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    generalBox,
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BorderRow extends StatelessWidget {
  const BorderRow({
    super.key,
    required this.title,
    this.icon,
    this.color,
    this.onPress,
  });
  final String title;
  final dynamic icon;
  final Color? color;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isDarkMode(context)
                ? MerathColors.grey_80
                : MerathColors.grey_10,
          ),
          borderRadius: BorderRadius.circular(horizontalSpacing / 4),
        ),
        padding: EdgeInsets.symmetric(
          vertical: verticalSpacing / 2,
          horizontal: horizontalSpacing / 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TranslatedText(title),
            if (icon is IconData)
              Icon(
                icon,
                size: horizontalSpacing,
                color: color,
              ),
            if (icon is String)
              BasicSvg(
                icon,
                color: color,
                width: horizontalSpacing,
              ),
          ],
        ),
      ),
    );
  }
}
