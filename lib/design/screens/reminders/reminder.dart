import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';
import '../../../logic/controllers/notification_controller.dart';

class Reminders extends StatelessWidget {
  const Reminders({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ReminderController(),
      builder: (ReminderController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context),
              Column(
                children: [
                  SearchHeader(
                    title: 'Alerts',
                    onSearchChange: controller.onSeatch,
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(routeAddrReminder);
                        },
                        child: Container(
                          decoration: circleDecoration(
                            color: MerathColors.white.withOpacity(0.1),
                          ),
                          padding: EdgeInsets.all(
                            horizontalSpacing / 2,
                          ),
                          child: Icon(
                            CupertinoIcons.add,
                            color: MerathColors.white,
                            size: horizontalSpacing * 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  generalBox,
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
                  generalSmallBox,
                  Expanded(
                    child: controller.remindersToView.isEmpty
                        ? Center(
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(routeAddrReminder);
                              },
                              child: Container(
                                decoration: cardDecoration(),
                                padding: EdgeInsets.symmetric(
                                  vertical: verticalSpacing * 2,
                                  horizontal: horizontalSpacing * 2,
                                ),
                                child: const NoRemindersW(),
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: controller.remindersToView.length,
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalSpacing,
                              vertical: verticalSpacing,
                            ),
                            itemBuilder: (context, index) {
                              final Map item =
                                  controller.remindersToView[index];
                              return Container(
                                decoration: cardDecoration(),
                                clipBehavior: Clip.antiAlias,
                                child: Dismissible(
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) {
                                    final bool isActive =
                                        Get.find<NotificationController>()
                                                .all
                                                .firstWhereOrNull((element) =>
                                                    element.title ==
                                                    item[kTitle]) !=
                                            null;
                                    if (isActive) {
                                      Get.find<NotificationController>()
                                          .cancelByTitle(item[kTitle]);
                                    }
                                    controller.reminders.remove(item);
                                    controller.remindersToView.remove(item);
                                    box.write(
                                        kNotifications, controller.reminders);
                                    controller.update();
                                  },
                                  key: Key(item.toString()),
                                  background: Container(
                                    decoration:
                                        cardDecoration(color: MerathColors.red),
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: horizontalSpacing),
                                        child: const Icon(
                                          CupertinoIcons.delete,
                                          color: MerathColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    color: MerathColors.background,
                                    //decoration: cardDecoration(),
                                    padding: generalPadding,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: circleDecoration(
                                            color: MerathColors.accent
                                                .withOpacity(0.2),
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: BasicSvg(
                                            Assets.assetsIconsReminder,
                                            color: MerathColors.accent,
                                            width: horizontalSpacing,
                                          ),
                                        ),
                                        generalSmallBox,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TranslatedText(
                                                item[kTitle],
                                                style: textStyles['black16mid'],
                                              ),
                                              generalSmallBox,
                                              Row(
                                                children: [
                                                  TranslatedText(
                                                    'Time',
                                                    style: textStyles['grey12'],
                                                  ),
                                                  TranslatedText(
                                                    ' :',
                                                    style: textStyles['grey12'],
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  TranslatedText(
                                                    '${item[kHour]}:${item[kMinute]}',
                                                    style:
                                                        textStyles['primary12'],
                                                  ),
                                                ],
                                              ),
                                              generalSmallBox,
                                              Row(
                                                children: [
                                                  TranslatedText(
                                                    'Days',
                                                    style: textStyles['grey12'],
                                                  ),
                                                  TranslatedText(
                                                    ' :',
                                                    style: textStyles['grey12'],
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: verticalSpacing,
                                                      child: ListView.separated(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final String day =
                                                              item[kDays]
                                                                  [index];
                                                          return TranslatedText(
                                                            day,
                                                            style: textStyles[
                                                                'primary12'],
                                                          );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return TranslatedText(
                                                            ' - ',
                                                            style: textStyles[
                                                                'primary12'],
                                                          );
                                                        },
                                                        itemCount: (item[kDays]
                                                                as List)
                                                            .length,
                                                      ),
                                                    ),
                                                  )
                                                  // TranslatedText(
                                                  //   '${item[kDays].isEmpty ? 'No days' : (item[kDays] as List)}',
                                                  //   style: textStyles['primary12'],
                                                  // ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          child: Switch.adaptive(
                                            value: Get.find<
                                                        NotificationController>()
                                                    .all
                                                    .firstWhereOrNull(
                                                        (element) =>
                                                            element.title ==
                                                            item[kTitle]) !=
                                                null,
                                            onChanged: (value) {
                                              controller
                                                  .switchNotification(item);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return generalBox;
                            },
                          ),
                  ),
                  bottomNavBox,
                  generalSmallBox
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
