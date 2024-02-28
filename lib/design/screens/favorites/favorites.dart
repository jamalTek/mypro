import '../../../general_exports.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
      init: FavoritesController(),
      builder: (FavoritesController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context),
              Column(
                children: [
                  const Header(
                    title: 'Favorite',
                    withBack: true,
                  ),
                  Expanded(
                    child: Container(
                      decoration: cardDecoration(),
                      padding: generalPadding,
                      margin: generalPadding,
                      child: Column(
                        children: [
                          generalSmallBox,
                          Row(
                            children: [
                              ...controller.types.map(
                                (e) => FavoriteCategory(
                                  item: e,
                                  isSelected: controller.selectedIndex ==
                                      controller.types.indexOf(e),
                                  onPress: () {
                                    controller.updateSelectedType(e);
                                  },
                                ),
                              ),
                            ],
                          ),
                          generalBox,
                          Expanded(
                            child: controller.items.isEmpty
                                ? const Center(
                                    child: TranslatedText('No items'),
                                  )
                                : ListView.separated(
                                    padding: EdgeInsets.only(
                                        bottom: verticalSpacing),
                                    itemBuilder: (context, index) {
                                      final Map e = controller.items[index];
                                      final bool isFavorite =
                                          e[kIsFavorite] ?? false;
                                      return VirtuesOfDeedsItem(
                                        item: e,
                                        isFavorite: isFavorite,
                                        onFav: () {
                                          controller.toggleFavorite(e);
                                        },
                                        onPress: () {
                                          Get.toNamed(
                                            routeArticle,
                                            arguments: {
                                              kType: kScientificContent,
                                              kItem: e,
                                            },
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return generalSmallBox;
                                    },
                                    itemCount: controller.items.length,
                                  ),
                          ),
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

class FavoriteCategory extends StatelessWidget {
  const FavoriteCategory({
    super.key,
    required this.item,
    required this.isSelected,
    this.onPress,
  });
  final Map item;
  final bool isSelected;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          children: [
            TranslatedText(
              item[kTitle],
              textAlign: TextAlign.center,
              style: isSelected
                  ? textStyles['primary16mid']
                  : textStyles['black16'],
            ),
            generalSmallBox,
            Divider(
              color:
                  isSelected ? MerathColors.primary : MerathColors.background,
            ),
          ],
        ),
      ),
    );
  }
}
