import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../../general_exports.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({
    super.key,
    required this.controller,
  });
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final today = HijriCalendar.now();
    return Stack(
      children: [
        CarouselSlider(
          items: controller.slider
              .map<Widget>(
                (e) => CachedNetworkImage(
                  imageUrl: e[kImageUrl],
                  fit: BoxFit.cover,
                  width: kDeviceWidth,
                ),
              )
              .toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            height: kDeviceHeight * 0.3,
            onPageChanged: controller.onPageChange,
          ),
        ),
        if (controller.slider.isEmpty)
          Positioned(
            bottom: 0,
            top: 0,
            right: horizontalSpacing,
            left: horizontalSpacing,
            child: const SafeArea(
              bottom: false,
              child: LoadingWidget(),
            ),
          )
        else
          Positioned(
            bottom: verticalSpacing,
            height: 8,
            left: 0,
            right: 0,
            child: Center(
              child: ListView.builder(
                itemCount: controller.slider.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final isSelected = controller.currentSliderIndex == index;
                  return AnimatedContainer(
                    duration: generalAnimationDuration,
                    width: isSelected ? 16 : 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(
                      horizontal: horizontalSpacing / 8,
                    ),
                    decoration: cardDecoration(
                      color: isSelected
                          ? MerathColors.white
                          : MerathColors.white.withOpacity(0.5),
                    ),
                  );
                },
              ),
            ),
          ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: horizontalSpacing / 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: controller.onMenuPress,
                  child: Container(
                    decoration: circleDecoration(
                      color: MerathColors.white.withOpacity(
                        0.9,
                      ),
                    ),
                    padding: EdgeInsets.all(horizontalSpacing / 3),
                    child: const Icon(
                      Icons.menu,
                      color: MerathColors.black,
                    ),
                  ),
                ),
                TranslatedText(
                  '${today.hYear}/${today.hMonth}/${today.hDay} هـ',
                  style: 'white18mid',
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
