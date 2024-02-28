import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';

class TextSizeUpdateSheet extends StatelessWidget {
  const TextSizeUpdateSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticleController>(
      builder: (ArticleController controller) {
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TranslatedText(
                      'تغيير حجم النص',
                      style: textStyles['black16mid'],
                    ),
                    Container(
                      decoration: circleDecoration(
                        color: MerathColors.shapeBackground,
                      ),
                      padding: EdgeInsets.all(horizontalSpacing / 3),
                      child: Icon(
                        CupertinoIcons.xmark,
                        size: horizontalSpacing * .7,
                      ),
                    ),
                  ],
                ),
                generalBox,
                Container(
                  decoration: cardDecoration(
                    color: MerathColors.grey_10,
                    borderRadius: BorderRadius.circular(horizontalSpacing / 4),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalSpacing / 2,
                    vertical: verticalSpacing / 2,
                  ),
                  child: Row(
                    children: [
                      const TranslatedText(
                        'A',
                        style: 'black16mid',
                      ),
                      generalSmallBox,
                      Expanded(
                        child: Stack(
                          children: [
                            const Positioned(
                              left: 4,
                              right: 4,
                              child: BasicSvg(Assets.assetsIconsSliderD),
                            ),
                            SizedBox(
                              //  width: kDeviceWidth,
                              child: SliderTheme(
                                data: SliderThemeData(
                                    overlayShape: SliderComponentShape.noThumb),
                                child: Slider(
                                  value: controller.newTextValue,
                                  min: -10,
                                  max: 10,
                                  activeColor: Colors.transparent,
                                  divisions: 6,
                                  inactiveColor: Colors.transparent,
                                  secondaryActiveColor: Colors.black,
                                  thumbColor: MerathColors.primary,
                                  onChanged: controller.updateTextSizeValue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      generalSmallBox,
                      const TranslatedText(
                        'A',
                        style: 'black22mid',
                      ),
                    ],
                  ),
                ),
                generalBox,
                generalBox,
                FullWidthButton(
                  text: 'Save',
                  onPress: controller.onSaveSize,
                  isDisabled:
                      controller.newTextValue == controller.customTextSize,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
