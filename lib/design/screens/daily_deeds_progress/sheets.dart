import 'package:table_calendar/table_calendar.dart';

import '../../../general_exports.dart';

class AddMeasurableSheet extends StatelessWidget {
  AddMeasurableSheet({
    super.key,
    required this.unit,
    required this.onPress,
  });
  final String unit;
  final void Function(String v) onPress;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: sheetDecoration(),
      padding: generalPadding,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TranslatedText(
                  'Add new progress',
                  style: textStyles['black16mid'],
                ),
                const CCloseButton(),
              ],
            ),
            generalBox,
            TranslatedText(
              'Add number',
              style: textStyles['black12'],
            ),
            generalSmallBox,
            CTextInput(
              isSmall: true,
              hint: getWord('Add number'), inputType: TextInputType.number,
              // suffixText: unit,
              // suffixStyle: textStyles['accent14'],
              suffixIcon: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalSpacing / 2),
                child: TranslatedText(
                  unit,
                  style: textStyles['accent14'],
                ),
              ),
              controller: textEditingController,
            ),
            generalBox,
            FullWidthButton(
              text: 'Add progress',
              // isDisabled: textEditingController.text.ise
              onPress: () {
                onPress(textEditingController.text);
              },
            )
          ],
        ),
      ),
    );
  }
}

class AddNotMeasurableSheet extends StatelessWidget {
  const AddNotMeasurableSheet({
    super.key,
    required this.onYes,
    required this.onNo,
  });
  final void Function() onYes;
  final void Function() onNo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: sheetDecoration(),
      padding: generalPadding,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TranslatedText(
                  'Add new progress',
                  style: textStyles['black16mid'],
                ),
                const CCloseButton(),
              ],
            ),
            generalBox,
            TranslatedText(
              'Did you work today',
              style: textStyles['black12'],
            ),
            generalBox,
            Row(
              children: [
                Expanded(
                  child: FullWidthButton(
                    text: 'Yes',
                    onPress: onYes,
                  ),
                ),
                generalSmallBox,
                Expanded(
                  child: FullWidthButton(
                    text: 'No',
                    isOutline: true,
                    onPress: onNo,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DaysSheet extends StatelessWidget {
  const DaysSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final DailyDeedProgressController controller =
        Get.find<DailyDeedProgressController>();
    return Container(
      decoration: sheetDecoration(),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2023),
              lastDay: DateTime.now().add(const Duration(days: 900)),
              focusedDay: DateTime.now(),
              calendarStyle: CalendarStyle(
                todayDecoration: circleDecoration(color: MerathColors.primary),
                isTodayHighlighted: false,
              ),
              calendarBuilders: CalendarBuilders(
                todayBuilder: (context, day, focusedDay) {
                  Center(
                    child: Container(
                      decoration: circleDecoration(
                        color: MerathColors.goldEnd,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        day.day.toString(),
                      ),
                    ),
                  );
                  return null;
                },
                defaultBuilder: (context, day, focusedDay) {
                  final bool isDayHigh =
                      controller.daysData.keys.toList().firstWhereOrNull(
                                (element) => element
                                    .toString()
                                    .contains(apiDayFormate(day)),
                              ) !=
                          null;

                  return Center(
                    child: Container(
                      decoration: circleDecoration(
                        color: isDayHigh ? MerathColors.goldEnd : null,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        day.day.toString(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.daysData.keys.toList().length,
                padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                itemBuilder: (context, index) {
                  final Map item = controller
                      .daysData[controller.daysData.keys.toList()[index]];
                  return Container(
                    decoration: cardDecoration(
                      color: MerathColors.shapeBackground,
                      borderRadius:
                          BorderRadius.circular(horizontalSpacing / 3),
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: verticalSpacing / 4,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: verticalSpacing / 2,
                      horizontal: horizontalSpacing,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TranslatedText(
                          item[kActionDateTime].toString().substring(0, 10),
                        ),
                        Row(
                          children: [
                            TranslatedText(
                              '${item[kProgressValue] ?? 1}',
                              style: isDarkMode(context)
                                  ? textStyles['white16mid']
                                  : textStyles['primary16mid'],
                            ),
                            generalSmallBox,
                            TranslatedText(
                              'Yes',
                              style: isDarkMode(context)
                                  ? textStyles['white16mid']
                                  : textStyles['primary16mid'],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
