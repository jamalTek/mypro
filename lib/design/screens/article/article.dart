import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../general_exports.dart';

class Article extends StatelessWidget {
  const Article({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticleController>(
      init: ArticleController(),
      builder: (ArticleController controller) {
        return Scaffold(
          backgroundColor: MerathColors.shapeBackground,
          body: SafeArea(
            child: Container(
              padding: generalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const BackButtonC(),
                      const Spacer(),
                      ArticleHeaderButton(
                        icon: Assets.assetsIconsTextSize,
                        onPress: controller.onTextSizePress,
                      ),
                      generalBox,
                      ArticleHeaderButton(
                        icon: Assets.assetsIconsShare,
                        onPress: () {
                          controller.onShare(controller.item);
                        },
                      ),
                      generalBox,
                      ArticleHeaderButton(
                        icon: controller.item[kIsFavorite]
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        onPress: controller.toggleFavorite,
                        iconColor: controller.item[kIsFavorite]
                            ? MerathColors.red
                            : null,
                      ),
                    ],
                  ),
                  generalBox,
                  TranslatedText(
                    controller.item[kTitle],
                    style:
                        textStyles['primary${controller.getTextSize(22)}semi'],
                  ),
                  generalBox,
                  if (controller.item[kThumbnail] == null)
                    Container(
                      decoration: cardDecoration(),
                      width: kDeviceWidth,
                      height: kDeviceHeight * 0.2,
                      alignment: Alignment.center,
                      child: BasicSvg(
                        Assets.assetsIconsLogo,
                        width: kDeviceWidth * 0.3,
                      ),
                    ),
                  if (controller.item[kThumbnail] != null)
                    Container(
                      decoration: cardDecoration(
                        color: MerathColors.background,
                      ),
                      width: kDeviceWidth,
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: controller.item[kThumbnail] ?? testImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  generalBox,
                  // TranslatedText(
                  //   controller.item[kTitle],
                  //   style: textStyles['black${controller.getTextSize(17)}semi'],
                  // ),
                  // generalSmallBox,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Html(
                        data: controller.item[kContent],
                        style: {
                          'body': Style(
                            fontSize: FontSize(14 + controller.customTextSize),
                            // fontWeight: FontWeight.bold,
                          ),
                        },
                      ),
                    ),
                  ),
                  // TranslatedText(
                  //   controller.item[kContent],
                  //   style: textStyles['grey${controller.getTextSize(16)}'],
                  // ),

                  // TranslatedText(
                  //   controller.item[kTitle],
                  //   style: textStyles['black${controller.getTextSize(17)}semi'],
                  // ),
                  // generalSmallBox,
                  // TranslatedText(
                  //   controller.item[kSubtitle],
                  //   style: textStyles['grey${controller.getTextSize(16)}'],
                  // ),

                  generalBox,
                  Visibility(
                    visible: !(controller.item['is_sound_hidden'] ?? true),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TranslatedText(
                              controller.audioDuration == Duration.zero
                                  ? 'Loading audio content..'
                                  : 'Audio content',
                              style: textStyles[
                                  'black${controller.getTextSize(17)}semi'],
                            ),
                            Text(
                              '${controller.audioDuration.inMinutes}:${controller.audioDuration.inSeconds}',
                              style: textStyles['black16semi'],
                            ),
                          ],
                        ),
                        generalBox,
                        Container(
                          decoration: cardDecoration(
                            color: MerathColors.lightGreen.withOpacity(
                              0.5,
                            ),
                          ),
                          // padding: generalPadding,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: controller.togglePlayer,
                                child: Container(
                                  decoration: circleDecoration(
                                    color: MerathColors.accent,
                                  ),
                                  padding:
                                      EdgeInsets.all(horizontalSpacing * 0.7),
                                  child: Icon(
                                    controller.player.state ==
                                            PlayerState.playing
                                        ? FontAwesomeIcons.pause
                                        : FontAwesomeIcons.play,
                                    size: horizontalSpacing * 0.7,
                                    color: MerathColors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                width: kDeviceWidth * 0.62,
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    // thumbShape: SliderComponentShape.noOverlay,
                                    overlayShape:
                                        SliderComponentShape.noOverlay,
                                    thumbShape: const RoundSliderThumbShape(
                                      elevation: 0,
                                      enabledThumbRadius: 6,
                                      pressedElevation: 0,
                                    ),
                                  ),
                                  child: Slider(
                                    value: controller
                                        .currentDuration.inMilliseconds
                                        .toDouble(),
                                    activeColor: MerathColors.accent,
                                    inactiveColor: MerathColors.grey_20,
                                    onChanged:
                                        controller.updateCurrentAudioPosition,
                                    max: controller.audioDuration.inMilliseconds
                                        .toDouble(),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${controller.currentDuration.inMinutes}:${controller.currentDuration.inSeconds}',
                                style: textStyles['black16semi'],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ArticleHeaderButton extends StatelessWidget {
  const ArticleHeaderButton({
    super.key,
    required this.icon,
    this.onPress,
    this.iconColor,
  });
  final dynamic icon;
  final void Function()? onPress;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPress,
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: circleDecoration(
          color: MerathColors.textColor.withOpacity(0.1),
        ),
        width: horizontalSpacing * 2.1,
        padding: EdgeInsets.all(horizontalSpacing / 2),
        child: icon is IconData
            ? Icon(icon, color: iconColor ?? MerathColors.textColor)
            : BasicSvg(
                icon,
                color: iconColor ?? MerathColors.textColor,
              ),
      ),
    );
  }
}
