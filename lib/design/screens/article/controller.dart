import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../general_exports.dart';
import 'text_size_sheet.dart';

class ArticleController extends GetxController {
  dynamic item;
  double customTextSize = 0;
  double newTextValue = 0;
  String path = '';
  AudioPlayer player = AudioPlayer();
  Duration audioDuration = Duration.zero;
  Duration currentDuration = Duration.zero;
  ScreenshotController screenshotController = ScreenshotController();

  List waveformData = [];
  String type = '';

  @override
  Future<void> onInit() async {
    super.onInit();
    item = Get.arguments[kItem];
    type = Get.arguments[kType];
    final Directory directory = await getTemporaryDirectory();
    final dbPath = join(directory.path, 'test.mp3');
    final ByteData data = await rootBundle.load(Assets.assetsSoundsTest);
    final List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    path = '${directory.path}/test.mp3';
    consoleLog(path);
    if (item[kSound] != null) {
      await player.setSource(UrlSource(item[kSound]));
      audioDuration = await player.getDuration() ?? Duration.zero;
    }
    update();
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

  Future<void> updateCurrentAudioPosition(double v) async {
    await player.seek(Duration(milliseconds: v.toInt()));
    getCurrentDuration();
    update();
  }

  void pausePlayer() {
    player.pause();
  }

  void resumePlayer() {
    player.resume();
    getCurrentDuration();
  }

  void togglePlayer() {
    if (player.state == PlayerState.playing) {
      pausePlayer();
    } else {
      resumePlayer();
    }
    update();
  }

  Future<void> getCurrentDuration() async {
    currentDuration = await player.getCurrentPosition() ?? Duration.zero;

    update();
    Future.delayed(100.milliseconds).then(
      (value) {
        if (player.state == PlayerState.playing) {
          getCurrentDuration();
        } else if (player.state == PlayerState.completed) {
          // currentDuration = audioDuration;
          update();
        }
      },
    );
  }

  void onTextSizePress() {
    Get.bottomSheet(
      const TextSizeUpdateSheet(),
      isScrollControlled: true,
    );
  }

  Future<void> onShare(Map item) async {
    Get.bottomSheet(
      Container(
        decoration: sheetDecoration(),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              generalBox,
              GestureDetector(
                onTap: () async {
                  startLoading();
                  await screenshotController
                      .captureFromLongWidget(
                    PostWidget(item: item),
                    pixelRatio: 10,
                  )
                      .then(
                    (Uint8List? image) async {
                      dismissLoading();
                      consoleLog(image.toString());
                      if (image != null) {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final imagePath =
                            await File('${directory.path}/image.png').create();
                        await imagePath.writeAsBytes(image);
                        final XFile xFile = XFile(imagePath.path);
                        await Share.shareXFiles([xFile]);
                      }
                    },
                  );
                },
                child: Container(
                  color: MerathColors.background,
                  width: kDeviceWidth,
                  alignment: Alignment.center,
                  child: const TranslatedText(
                    'Post',
                    style: 'black22mid',
                  ),
                ),
              ),
              Divider(
                height: verticalSpacing * 2,
              ),
              GestureDetector(
                onTap: () async {
                  startLoading();
                  await screenshotController
                      .captureFromWidget(
                    StoryWidget(item: item),
                    pixelRatio: 10,
                  )
                      .then(
                    (Uint8List? image) async {
                      dismissLoading();
                      //consoleLog(image.toString());
                      if (image != null) {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final imagePath = await File(
                          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png',
                        ).create();
                        await imagePath.writeAsBytes(image);
                        final XFile xFile = XFile(imagePath.path);
                        await Share.shareXFiles([xFile]);
                      }
                    },
                  );
                },
                child: Container(
                  color: MerathColors.background,
                  width: kDeviceWidth,
                  alignment: Alignment.center,
                  child: const TranslatedText(
                    'Story',
                    style: 'black22mid',
                  ),
                ),
              ),
              Divider(
                height: verticalSpacing * 2,
              ),
              GestureDetector(
                onTap: () {
                  Share.share(stripHtmlIfNeeded(item[kContent]));
                },
                child: Container(
                  color: MerathColors.background,
                  width: kDeviceWidth,
                  alignment: Alignment.center,
                  child: const TranslatedText(
                    'Text',
                    style: 'black22mid',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );

    // await screenshotController
    //     .capture(delay: const Duration(milliseconds: 10))
    //     .then(
    //   (Uint8List? image) async {
    //     consoleLog(image.toString());
    //     if (image != null) {
    //       final directory = await getApplicationDocumentsDirectory();
    //       final imagePath = await File('${directory.path}/image.png').create();
    //       await imagePath.writeAsBytes(image);
    //       final XFile xFile = XFile(imagePath.path);
    //       await Share.shareXFiles([xFile]);
    //     }

    //     /// Share Plugin
    //   },
    // );
  }

  void updateTextSizeValue(double v) {
    newTextValue = v;
    update();
  }

  void onSaveSize() {
    customTextSize = newTextValue;
    update();
    Get.back();
  }

  void toggleFavorite() {
    item[kIsFavorite] = !item[kIsFavorite];
    if (Get.isRegistered<ProphetBiographyController>()) {
      final Map oldItem = Get.find<ProphetBiographyController>()
          .content
          .firstWhere((element) => element[kId] == item[kId]);
      consoleLog(oldItem);
      oldItem[kIsFavorite] = item[kIsFavorite];
      Get.find<ProphetBiographyController>().update();
    } else {
      final Map oldItem = Get.find<VirtuesOfDeedsController>()
          .content
          .firstWhere((element) => element[kId] == item[kId]);
      consoleLog(oldItem);
      oldItem[kIsFavorite] = item[kIsFavorite];
      Get.find<VirtuesOfDeedsController>().update();
    }
    update();
    if (item[kIsFavorite]) {
      ApiRequest(
        path: apiFavorite,
        method: postMethod,
        body: {
          kType: type,
          kReferenceId: item[kId],
        },
      ).request(
        onSuccess: (data, response) {},
      );
    } else {
      ApiRequest(
        path: '$apiFavorite/${item[kId]}/$type',
        method: deleteMethod,
      ).request(
        onSuccess: (data, response) {},
      );
    }
  }

  int getTextSize(int originalSize) {
    return originalSize + (customTextSize.toInt());
  }
}

class StoryWidget extends StatelessWidget {
  const StoryWidget({
    super.key,
    required this.item,
  });
  final Map item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kDeviceHeight,
      width: kDeviceWidth,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.assetsImagesStoryT,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: generalPadding,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    padding: generalPadding,
                    width: double.infinity,
                    decoration: cardDecoration(
                        color: MerathColors.background.withOpacity(0.5)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TranslatedText(
                          item[kTitle],
                          style: textStyles['black30semi'],
                          textAlign: TextAlign.center,
                        ),
                        generalBox,
                        TranslatedText(
                          stripHtmlIfNeeded(item[kShareText].isEmpty
                              ? item[kContent]
                              : item[kShareText]),
                          style: textStyles['black18mid']!.copyWith(
                            color: MerathColors.textColor.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 9,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.item,
  });
  final Map item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kDeviceWidth,
      width: kDeviceWidth,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.assetsImagesPostT,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: generalPadding,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    padding: generalPadding,
                    decoration: cardDecoration(
                        color: MerathColors.background.withOpacity(0.5)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TranslatedText(
                          item[kTitle],
                          style: textStyles['black30semi'],
                          textAlign: TextAlign.center,
                        ),
                        generalBox,
                        TranslatedText(
                          stripHtmlIfNeeded(item[kShareText].isEmpty
                              ? item[kContent]
                              : item[kShareText]),
                          style: textStyles['black18mid']!.copyWith(
                            color: MerathColors.textColor.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 9,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
