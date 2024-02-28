import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../general_exports.dart';
import 'sheets.dart';

class DailyDeedProgress extends StatelessWidget {
  const DailyDeedProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyDeedProgressController>(
      init: DailyDeedProgressController(),
      builder: (DailyDeedProgressController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context),
              SafeArea(
                child: Container(
                  padding: generalPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          BackButtonC(),
                        ],
                      ),
                      generalBox,
                      TranslatedText(
                        controller.item[kTitle],
                        style: textStyles['black20semi'],
                      ),
                      generalBox,
                      Row(
                        children: [
                          Expanded(
                            child: InfoBox(
                              text: controller.daysData.keys.length.toString(),
                              title: 'Total days',
                            ),
                          ),
                          generalSmallBox,
                          Expanded(
                            child: InfoBox(
                              text: controller.totalProgress.toString(),
                              title: 'Total progress',
                            ),
                          ),
                        ],
                      ),
                      generalBox,
                      generalBox,
                      Visibility(
                        visible: controller.item[kHabitType] == kMeasurable,
                        child: Center(
                          child: SizedBox(
                            width: kDeviceWidth - horizontalSpacing * 4,
                            child: ProgressCircle(
                              percentage: controller.getPercentage(),
                            ),
                          ),
                        ),
                      ),
                      generalBox,
                      generalBox,
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(const DaysSheet());
                        },
                        child: Container(
                          decoration: cardDecoration(
                            color: MerathColors.shapeBackground,
                            borderRadius:
                                BorderRadius.circular(horizontalSpacing / 2),
                          ),
                          padding: generalPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TranslatedText(
                                'view days',
                                style: textStyles['black16'],
                              ),
                              Icon(
                                CupertinoIcons.arrow_left,
                                size: horizontalSpacing,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      FullWidthButton(
                        text: 'Add progress',
                        onPress: controller.onAddProgress,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({
    super.key,
    required this.title,
    required this.text,
  });
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardDecoration(
        color: MerathColors.goldEnd,
        borderRadius: BorderRadius.circular(
          horizontalSpacing / 2,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: verticalSpacing / 2,
        horizontal: horizontalSpacing / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TranslatedText(
            title,
            style:
                textStyles['black16mid']!.copyWith(color: MerathColors.black),
          ),
          generalSmallBox,
          TranslatedText(
            text,
            style: textStyles['primary16mid'],
          ),
        ],
      ),
    );
  }
}

class ProgressCircle extends StatelessWidget {
  const ProgressCircle({
    super.key,
    required this.percentage,
  });
  final double percentage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: circleDecoration(color: MerathColors.shapeBackground),
          alignment: Alignment.center,
          width: kDeviceWidth - horizontalSpacing * 4,
          height: kDeviceWidth - horizontalSpacing * 4,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: TranslatedText(
            '${percentage * 100}%',
            style: textStyles['black14']!.copyWith(fontSize: 58),
          ),
        ),
        Positioned.fill(
          child: CircularPercentIndicator(
            percent: percentage ?? 0.7,
            lineWidth: 12,
            radius: (kDeviceWidth - horizontalSpacing * 4) / 2,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.transparent,
            progressColor: MerathColors.accent,
            animation: true,
            animateFromLastPercent: true, animationDuration: 400,
            curve: Curves.easeOutCubic,
            //restartAnimation: true,
          ),
        ),
      ],
    );
  }
}
