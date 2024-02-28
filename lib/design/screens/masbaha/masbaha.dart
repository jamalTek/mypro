import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../general_exports.dart';

class Masbaha extends StatelessWidget {
  const Masbaha({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MasbahaController>(
      init: MasbahaController(),
      builder: (MasbahaController controller) {
        return Scaffold(
          body: Stack(children: [
            getBackground(context),
            Column(
              children: [
                const Header(
                  title: 'Masbaha',
                  withBack: true,
                ),
                Expanded(
                  child: Container(
                    decoration: cardDecoration(),
                    padding: generalPadding,
                    margin: generalPadding,
                    width: kDeviceWidth,
                    child: Column(
                      children: [
                        generalBox,
                        MasbahaCounter(
                          controller: controller,
                        ),
                        generalSmallBox,
                        GestureDetector(
                          onTap: () {
                            controller.updateCurrentValue(0);
                          },
                          child: Container(
                            decoration: cardDecoration(
                              color: MerathColors.primary,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: verticalSpacing / 2,
                              horizontal: horizontalSpacing,
                            ),
                            child: TranslatedText(
                              'Reset',
                              style: textStyles['white14'],
                            ),
                          ),
                        ),
                        generalBox,
                        GestureDetector(
                          onTap: () {
                            controller.showCounterOptions();
                          },
                          child: Container(
                            decoration: cardDecoration(
                              color: MerathColors.shapeBackground,
                              borderRadius: BorderRadius.circular(
                                horizontalSpacing / 2,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: verticalSpacing / 2,
                              horizontal: horizontalSpacing,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                TranslatedText('Counter options'),
                                Icon(CupertinoIcons.arrow_left)
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            controller.updateCurrentValue(
                                controller.currentValue + 1);
                          },
                          child: AvatarGlow(
                            endRadius: kDeviceWidth * 0.24,
                            glowColor: MerathColors.goldEnd,
                            showTwoGlows: false,
                            child: AvatarGlow(
                              endRadius: kDeviceWidth * 0.2,
                              glowColor: MerathColors.goldEnd,
                              showTwoGlows: false,
                              child: Container(
                                decoration: circleDecoration(
                                    color: MerathColors.goldEnd),
                                width: kDeviceWidth * 0.3,
                                alignment: Alignment.center,
                                child: TranslatedText(
                                  'Press',
                                  style: textStyles['black20mid'],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                generalBox,
              ],
            )
          ]),
        );
      },
    );
  }
}

class MasbahaCounter extends StatelessWidget {
  const MasbahaCounter({
    super.key,
    required this.controller,
  });
  final MasbahaController controller;
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
          child: TranslatedText(
            controller.currentValue,
            style: textStyles['black14']!.copyWith(fontSize: 58),
          ),
        ),
        Positioned.fill(
          child: CircularPercentIndicator(
            percent: controller.getPercentage(),
            lineWidth: 12,
            radius: (kDeviceWidth - horizontalSpacing * 4) / 2,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: MerathColors.background,
            progressColor: MerathColors.primary,
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
