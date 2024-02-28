import '../../../general_exports.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (SettingsController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context),
              Column(
                children: [
                  const Header(
                    title: 'Settings',
                    withBack: true,
                  ),
                  Expanded(
                    child: Container(
                      decoration: cardDecoration(),
                      padding: generalPadding,
                      margin: generalPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TranslatedText(
                            'Account settings',
                            style: textStyles['black28mid'],
                          ),
                          generalBox,
                          ...controller.items.map(
                            (e) => SettingSwitch(item: e),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(routeAppLanguage);
                            },
                            child: Container(
                              color: MerathColors.background,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: verticalSpacing / 2,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: TranslatedText(
                                                'App language',
                                                style: textStyles['black18'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            TranslatedText(
                                              controller.getLanguageName(),
                                            ),
                                            generalSmallBox,
                                            const Icon(Icons.arrow_forward)
                                          ],
                                        ),
                                        generalSmallBox,
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: verticalSpacing * 1.2,
                                  )
                                ],
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
            ],
          ),
        );
      },
    );
  }
}

class SettingSwitch extends StatelessWidget {
  const SettingSwitch({
    super.key,
    required this.item,
  });
  final Map item;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TranslatedText(
                    item[kTitle],
                    style: textStyles['black18'],
                  ),
                ),
              ),
            ),
            generalSmallBox,
            Switch.adaptive(
              value: item[kIsSelected],
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: item[kOnPress],
            ),
          ],
        ),
        Divider(
          height: verticalSpacing * 1.2,
        )
      ],
    );
  }
}
