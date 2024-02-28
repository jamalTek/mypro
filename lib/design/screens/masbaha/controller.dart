import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../general_exports.dart';

class MasbahaController extends GetxController {
  int currentValue = box.read(kCounter) ?? 0;
  num currentGoal = double.infinity;
  List<Map> counterOptions = [
    {
      kTitle: '33 times',
      kValue: 33,
    },
    {
      kTitle: '100 times',
      kValue: 100,
    },
    {
      kTitle: '1000 times',
      kValue: 1000,
    },
    {
      kTitle: 'no limit',
      kValue: double.infinity,
    },
  ];

  void updateCurrentValue(int newValue) {
    currentValue = newValue;
    if (currentValue == currentGoal) {
      HapticFeedback.vibrate();
    }
    update();
    box.write(kCounter, newValue);
  }

  double getPercentage() {
    return currentValue / currentGoal > 1 ? 1 : currentValue / currentGoal;
  }

  void showCounterOptions() {
    Get.bottomSheet(
      Container(
        decoration: cardDecoration(),
        padding: generalPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TranslatedText(
                  'Counter options',
                  style: textStyles['black16mid'],
                ),
                Container(
                  decoration:
                      circleDecoration(color: MerathColors.shapeBackground),
                  padding: const EdgeInsets.all(2),
                  child: Icon(
                    CupertinoIcons.xmark,
                    size: horizontalSpacing,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: verticalSpacing * 10,
              child: CupertinoPicker(
                itemExtent: verticalSpacing * 2,
                scrollController: FixedExtentScrollController(
                  initialItem: counterOptions.indexOf(
                      counterOptions.firstWhereOrNull(
                              (element) => element[kValue] == currentGoal) ??
                          counterOptions.first),
                ),
                onSelectedItemChanged: (value) {
                  currentGoal = counterOptions[value][kValue];
                  update();
                },
                children: counterOptions
                    .map(
                      (e) => TranslatedText(
                        e[kTitle],
                      ),
                    )
                    .toList(),
              ),
            ),
            generalBox,
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
