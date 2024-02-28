import 'package:flutter_animate/flutter_animate.dart';

import '../../../general_exports.dart';

class ProphetBiography extends StatelessWidget {
  const ProphetBiography({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProphetBiographyController>(
      init: ProphetBiographyController(),
      autoRemove: false,
      builder: (ProphetBiographyController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context),
              Column(
                children: [
                  SearchHeader(
                    title: 'Prophet Biography',
                    textEditingController: controller.searchContrller,
                    onSubmit: controller.searchContent,
                    onSearchChange: (v) {
                      if (v.isEmpty) {
                        hideKeyboard();
                        controller.reset();
                      } else {
                        controller.onSearchChange();
                      }
                    },
                    withBack: true,
                  ),
                  generalBox,
                  SizedBox(
                    height: verticalSpacing * 2,
                    child: ListView.separated(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalSpacing),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final String title =
                            controller.categories[index][kTitle];
                        final bool isSelected =
                            index == controller.selectedCategory;

                        return GestureDetector(
                          onTap: () {
                            controller.updateSelectedCategory(index);
                          },
                          child: AnimatedContainer(
                            duration: generalAnimationDuration,
                            curve: Curves.easeOut,
                            decoration: cardDecoration(
                              color: isSelected
                                  ? MerathColors.primary
                                  : getLightColoredBG(context),
                              borderRadius: BorderRadius.circular(
                                horizontalSpacing / 2,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: isSelected
                                  ? horizontalSpacing * 0.8
                                  : horizontalSpacing / 2,
                            ),
                            child: Center(
                              child: TranslatedText(
                                title,
                                style: isSelected ? 'white18' : 'black18',
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return generalSmallBox;
                      },
                    ),
                  ),
                  generalBox,
                  Expanded(
                    child: controller.content.isEmpty && controller.isLoading
                        ? Center(
                            child: SizedBox(
                              width: kDeviceWidth * 0.4,
                              height: kDeviceWidth * 0.4,
                              child: const LoadingWidget(),
                            ),
                          )
                        : controller.content.isEmpty
                            ? Center(
                                child: Container(
                                  decoration: cardDecoration(),
                                  padding: generalPadding,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      BasicSvg(
                                        Assets.assetsIconsIslamVectors,
                                        width: kDeviceWidth * 0.3,
                                      ),
                                      generalBox,
                                      const TranslatedText(
                                        'No Virtues',
                                        style: 'grey18',
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Center(
                                child: AnimatedContainer(
                                  duration: generalAnimationDuration,
                                  curve: Curves.easeOutCirc,
                                  decoration: cardDecoration(),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: horizontalSpacing),
                                  width: controller.isLoading
                                      ? kDeviceWidth * 0.4
                                      : kDeviceWidth,
                                  height: controller.isLoading
                                      ? kDeviceWidth * 0.4
                                      : kDeviceHeight * 0.65,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: horizontalSpacing,
                                  ),
                                  //  width: kDeviceWidth,
                                  child: controller.isLoading
                                      ? Center(
                                          child: const LoadingWidget()
                                              .animate()
                                              .move(
                                                curve: Curves.easeOutCirc,
                                                duration:
                                                    generalAnimationDuration,
                                              )
                                              .scale(),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            generalBox,
                                            const TranslatedText(
                                              'Content',
                                              style: 'black18semi',
                                            ),
                                            generalSmallBox,
                                            Expanded(
                                              child: ListView.separated(
                                                padding: EdgeInsets.only(
                                                    bottom: verticalSpacing),
                                                itemBuilder: (context, index) {
                                                  final Map e =
                                                      controller.content[index];
                                                  bool isFavorite =
                                                      e[kIsFavorite] ?? false;
                                                  if ((box.read(kProphetBiography)
                                                              as List)
                                                          .firstWhereOrNull(
                                                        (element) =>
                                                            element[kTitle] ==
                                                            e[kTitle],
                                                      ) !=
                                                      null) {
                                                    controller.content[index]
                                                        [kIsFavorite] = true;
                                                    isFavorite = true;
                                                  }
                                                  return VirtuesOfDeedsItem(
                                                    item: e,
                                                    isFavorite: isFavorite,
                                                    onFav: () {
                                                      controller
                                                          .toggleFavorite(e);
                                                    },
                                                    onPress: () {
                                                      Get.toNamed(
                                                        routeArticle,
                                                        arguments: {
                                                          kType:
                                                              kProphetBiography,
                                                          kItem: e,
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return generalSmallBox;
                                                },
                                                itemCount:
                                                    controller.content.length,
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                              ),
                  ),
                  generalBox,
                  //  bottomNavBox,
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
