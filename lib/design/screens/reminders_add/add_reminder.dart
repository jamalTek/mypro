import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../general_exports.dart';

class AddReminder extends StatelessWidget {
  const AddReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddReminderController>(
      init: AddReminderController(),
      builder: (AddReminderController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context),
              Column(
                children: [
                  GestureDetector(
                    // onTap: controller.viewAll,
                    child: SearchHeader(
                      title: 'Add alert',
                      withBack: true,
                      onSearchChange: controller.onSeatch,
                    ),
                  ),
                  generalSmallBox,
                  SizedBox(
                    height: verticalSpacing * 3,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalSpacing,
                      ),
                      itemBuilder: (context, index) {
                        final Map e = controller.categories[index];
                        final bool isSelected =
                            index == controller.selectedCategory;
                        return GestureDetector(
                          onTap: () {
                            controller.updateSelectedCategory(index);
                          },
                          child: AnimatedContainer(
                            duration: generalDuration,
                            curve: Curves.easeOut,
                            decoration: cardDecoration(
                              borderRadius:
                                  BorderRadius.circular(horizontalSpacing / 2),
                              color: isSelected ? MerathColors.goldEnd : null,
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              horizontal: isSelected
                                  ? horizontalSpacing * 1.2
                                  : horizontalSpacing,
                              vertical: verticalSpacing / 2,
                            ),
                            child: Row(
                              children: [
                                BasicSvg(
                                  e[kIcon],
                                  width: horizontalSpacing,
                                  color: isSelected
                                      ? MerathColors.black
                                      : isDarkMode(context)
                                          ? MerathColors.grey
                                          : null,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                TranslatedText(
                                  e[kTitle],
                                  style: !isSelected
                                      ? isDarkMode(context)
                                          ? 'grey16mid'
                                          : 'black16mid'
                                      : textStyles['black16mid']!
                                          .copyWith(color: MerathColors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: controller.categories.length,
                      separatorBuilder: (context, index) {
                        return generalSmallBox;
                      },
                    ),
                  ),
                  generalBox,
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalSpacing,
                      ).copyWith(bottom: verticalSpacing * 2),
                      itemCount: controller.remindersToView.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return generalSmallBox;
                      },
                      itemBuilder: (context, index) {
                        final Map item = controller.remindersToView[index];
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalSpacing,
                              vertical: verticalSpacing / 2),
                          decoration: cardDecoration(),
                          child: Row(
                            children: [
                              Container(
                                decoration: circleDecoration(
                                  color: MerathColors.primary.withOpacity(0.2),
                                ),
                                padding: EdgeInsets.all(horizontalSpacing / 3),
                                child: BasicSvg(
                                  Assets.assetsIconsReminder,
                                  color: MerathColors.primary,
                                  width: horizontalSpacing,
                                ),
                              ),
                              generalSmallBox,
                              TranslatedText(
                                item[kTitle],
                                style: textStyles['black16mid'],
                              ),
                              const Spacer(),
                              CupertinoButton(
                                onPressed: () {
                                  controller.lastSelectedReminder = item;
                                  controller.showReminderSetting(item);
                                },
                                padding: EdgeInsets.zero,
                                child: const TranslatedText('Add'),
                              ),
                            ],
                          ),
                        )
                            .animate()
                            .slide(
                              duration: Duration(
                                milliseconds: 200 + (index * 50),
                              ),
                            )
                            .fade(
                              delay: const Duration(
                                milliseconds: 10,
                              ),
                            );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
