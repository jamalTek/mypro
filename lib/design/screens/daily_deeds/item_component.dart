import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';

class DailyDeedWidget extends StatelessWidget {
  const DailyDeedWidget({
    super.key,
    required this.item,
  });

  final Map item;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyDeedsController>(builder: (controller) {
      return Container(
        decoration: cardDecoration(color: controller.color),
        clipBehavior: Clip.hardEdge,
        child: Dismissible(
          onUpdate: (details) {
            final DailyDeedsController controller =
                Get.find<DailyDeedsController>();
            if (details.direction == DismissDirection.endToStart) {
              controller.color = MerathColors.green;
              controller.update();
              return;
            } else {
              controller.color = MerathColors.red;
              controller.update();
            }
          },
          confirmDismiss: (direction) async {
            final DailyDeedsController controller =
                Get.find<DailyDeedsController>();
            if (direction == DismissDirection.endToStart) {
              Get.toNamed(routeAddDailyDeed, arguments: item);
              return false;
            }
            controller.color = MerathColors.red;
            controller.update();
            // final DailyDeedsController controller =Get.find<DailyDeedsController>();
            controller.deleteItem(item);
            if (direction == DismissDirection.endToStart) {
              return false;
            } else {
              return true;
            }
          },
          onDismissed: (direction) {},
          background: Container(
            decoration: cardDecoration(
              color: MerathColors.red,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                  padding: generalPadding,
                  child: const Icon(
                    CupertinoIcons.delete,
                    color: MerathColors.white,
                  )),
            ),
          ),
          secondaryBackground: Container(
            decoration: cardDecoration(
              color: MerathColors.green,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: generalPadding,
                child: const Icon(
                  CupertinoIcons.eyedropper_halffull,
                  color: MerathColors.white,
                ),
              ),
            ),
          ),
          // direction: DismissDirection.startToEnd,
          key: Key(item.toString()),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(routeDailyDeedProgress, arguments: item);
            },
            child: Container(
              decoration: cardDecoration(),
              padding: generalPadding,
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TranslatedText(
                        item[kTitle],
                        style: 'black16mid',
                      ),
                      const TranslatedText(
                        'View report',
                        style: 'gold14mid',
                      ),
                    ],
                  ),
                  generalBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (item[kReminderNumber] != null)
                        TranslatedText(
                          '${item[kGoalNumber]} ${item[kUnit]}',
                          style: 'grey12',
                        ),
                      Visibility(
                        visible: item[kReminderNumber] != null,
                        child: TranslatedText(
                          '${getWord('Remind per')} ${item[kReminderNumber]} ${getWord(item[kReminderFrequencyType])}',
                          style: 'grey12',
                        ),
                      ),
                      Visibility(
                        visible: item[kReminderTime] != null,
                        child: TranslatedText(
                          item[kReminderTime],
                          style: 'grey12',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
