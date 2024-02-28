import 'package:showcaseview/showcaseview.dart';

import '../../../general_exports.dart';
import 'home_slider.dart';
import 'quick_access.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      autoRemove: false,
      builder: (HomeController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context),
              Column(
                children: [
                  HomeSlider(
                    controller: controller,
                  ),
                  Padding(
                    padding: generalPadding,
                    child: Column(
                      children: [
                        Showcase(
                          key: controller.reminderQuickAcceessCase,
                          description: getWord(
                              'You can browse the Prophet’s biography and access the rosary and favorites from here.'),
                          title: getWord('Quick access'),
                          child: QuickAccess(
                            controller: controller,
                          ),
                        ),
                        generalBox,
                        Container(
                          decoration: cardDecoration(),
                          padding: generalPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TranslatedText(
                                'Reminders',
                                style: 'black18semi',
                              ),
                              generalSmallBox,
                              SizedBox(
                                height: kDeviceHeight * 0.3,
                                width: kDeviceWidth,
                                child: controller.reminderToShow.isEmpty
                                    ? Showcase(
                                        description: getWord(
                                            'When you add alerts, they will appear here.'),
                                        title: getWord('Reminders'),
                                        key: controller.reminderShowCase,
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(routeAddrReminder);
                                          },
                                          child: NoRemindersW(
                                            isThereOtherDays:
                                                controller.isThereOtherDays,
                                          ),
                                        ),
                                      )
                                    : ListView.separated(
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          final Map e =
                                              controller.reminderToShow[index];
                                          return ReminderHomeWidget(
                                            title: e[kTitle],
                                            subtitle:
                                                '${e[kHour]}:${e[kMinute]}',
                                            remaining: remainingTime(
                                              e[kHour],
                                              e[kMinute],
                                            ), // e[kRemaining],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return generalBox;
                                        },
                                        itemCount:
                                            controller.reminderToShow.length,
                                      ),
                              ),
                              // ...controller.reminders.map(
                              //   (e) => ReminderHomeWidget(
                              //     title: e[kTitle],
                              //     subtitle: e[kSubtitle],
                              //     remaining: e[kRemaining],
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ],
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

class ReminderHomeWidget extends StatelessWidget {
  const ReminderHomeWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.remaining,
  });
  final String title;
  final String subtitle;
  final String remaining;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardDecoration(
        color: MerathColors.accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(horizontalSpacing / 2),
      ),
      padding: EdgeInsets.symmetric(
        vertical: verticalSpacing / 2,
        horizontal: horizontalSpacing / 2,
      ),
      child: Row(
        children: [
          Container(
            decoration: circleDecoration(
              color: MerathColors.accent.withOpacity(0.2),
            ),
            padding: EdgeInsets.only(
              bottom: verticalSpacing * 0.8,
              top: verticalSpacing / 2,
              left: horizontalSpacing / 2,
              right: horizontalSpacing / 2 * 0.8,
            ),
            child: BasicSvg(
              Assets.assetsIconsReminder,
              color: MerathColors.primary,
              width: horizontalSpacing * 1.2,
            ),
          ),
          generalSmallBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TranslatedText(
                title,
                style: 'black16mid',
              ),
              const SizedBox(
                height: 4,
              ),
              TranslatedText(
                subtitle,
                style: textStyles['black12mid']!.copyWith(
                  color: MerathColors.textColor.withOpacity(0.8),
                ),
              ),
            ],
          ),
          //const Spacer(),
          generalBox,
          Expanded(
            child: FittedBox(
              child: TranslatedText(
                '${getWord('Remaining')} $remaining',
                style: 'gold14mid',
              ),
            ),
          ),
          generalSmallBox,
        ],
      ),
    );
  }
}
