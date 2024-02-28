import 'package:flutter/cupertino.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../general_exports.dart';
import 'item_component.dart';

class DailyDeeds extends StatelessWidget {
  const DailyDeeds({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DailyDeedsController(),
      builder: (DailyDeedsController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context),
              Column(
                children: [
                  SearchHeader(
                    title: 'Daily deeds',
                    actions: [
                      Showcase(
                        key: controller.showcaseAddDailyDeed,
                        description:
                            getWord('To add a new daily habit from here'),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(routeAddDailyDeed);
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
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalSpacing,
                        vertical: verticalSpacing,
                      ).copyWith(bottom: verticalSpacing * 6),
                      itemBuilder: (context, index) {
                        final Map item = controller.dailyDeeds[index];
                        return DailyDeedWidget(item: item);
                      },
                      separatorBuilder: (context, index) {
                        return generalBox;
                      },
                      itemCount: controller.dailyDeeds.length,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
