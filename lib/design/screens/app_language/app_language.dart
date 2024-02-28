import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';

class AppLanguageScreen extends StatelessWidget {
  const AppLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AppLanguageScreenController(),
      builder: (AppLanguageScreenController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context),
              Column(
                children: [
                  const Header(
                    title: 'App language',
                    withBack: true,
                  ),
                  Expanded(
                    child: Container(
                      decoration: cardDecoration(),
                      padding: generalPadding,
                      margin: generalPadding,
                      width: kDeviceWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TranslatedText(
                            'Select app language',
                            style: textStyles['black28'],
                          ),
                          generalBox,
                          ...controller.languages.map(
                            (e) => LanguageRow(
                              title: e['label'],
                              onPress: () {
                                controller.changeLanguage(
                                  e[kValue],
                                );
                                controller.updateLanguage(
                                    controller.languages.indexOf(e));
                              },
                              isSelected: controller.languages.indexOf(e) ==
                                  controller.selectedLanguageIndex,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class LanguageRow extends StatelessWidget {
  const LanguageRow({
    this.isSelected = false,
    super.key,
    required this.title,
    required this.onPress,
  });
  final bool isSelected;
  final String title;
  final void Function() onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        color: MerathColors.background,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: verticalSpacing / 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TranslatedText(
                    title,
                    style: isSelected
                        ? textStyles['accent18']
                        : textStyles['black18'],
                  ),
                  Visibility(
                    visible: isSelected,
                    child: const Icon(
                      CupertinoIcons.check_mark,
                      color: MerathColors.accent,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: verticalSpacing,
            )
          ],
        ),
      ),
    );
  }
}
