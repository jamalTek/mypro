import 'package:showcaseview/showcaseview.dart';

import '../../../general_exports.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (MainController controller) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                child: controller.screens[controller.selectedScreenIndex]
                    [kWidget],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        horizontalSpacing,
                      ),
                    ),
                    color: MerathColors.background,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalSpacing / 2)
                          .copyWith(
                    top: verticalSpacing / 2,
                  ),
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDeviceWidth * 0.07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: controller.screens.map(
                          (e) {
                            final int index = controller.screens.indexOf(e);
                            final bool isSelected =
                                controller.selectedScreenIndex == index;
                            return GestureDetector(
                              onTap: () {
                                controller.updateSelectedScreen(index);
                              },
                              child: index == 0
                                  ? Container(
                                      color: Colors.transparent,
                                      height: kDeviceHeight * 0.06,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: BasicSvg(
                                              e[kIcon],
                                              height: 30,
                                              color: isSelected
                                                  ? MerathColors.primary
                                                  : null,
                                            ),
                                          ),
                                          SizedBox(height: verticalSpacing / 4),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: TranslatedText(
                                              getWord(
                                                e[kName],
                                              ),
                                              style: isSelected
                                                  ? 'primary12mid'
                                                  : 'grey12',
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Showcase(
                                      key: index == 1
                                          ? controller.showCaseVOfDeedsKey
                                          : index == 2
                                              ? controller.showCaseDailyDeedsKey
                                              : controller.showCaseRemindersKey,
                                      description: getWord(index == 1
                                          ? 'Go here to browse Business Virtues.'
                                          : index == 2
                                              ? 'You can add custom daily chores, go here.'
                                              : 'And here are the alerts.'),
                                      child: Container(
                                        color: Colors.transparent,
                                        height: kDeviceHeight * 0.06,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: BasicSvg(
                                                e[kIcon],
                                                height: 30,
                                                color: isSelected
                                                    ? MerathColors.primary
                                                    : null,
                                              ),
                                            ),
                                            SizedBox(
                                                height: verticalSpacing / 4),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: TranslatedText(
                                                getWord(
                                                  e[kName],
                                                ),
                                                style: isSelected
                                                    ? 'primary12mid'
                                                    : 'grey12',
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
