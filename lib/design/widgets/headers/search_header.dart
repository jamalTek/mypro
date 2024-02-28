import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({
    super.key,
    required this.title,
    this.onSearchChange,
    this.onSubmit,
    this.actions,
    this.textEditingController,
    this.withBack = false,
  });
  final String title;
  final void Function(String v)? onSearchChange;
  final void Function(String v)? onSubmit;
  final List<Widget>? actions;
  final bool withBack;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(horizontalSpacing * 1.5),
        ),
        color: isDarkMode(context)
            ? MerathColors.shapeBackground
            : MerathColors.primary,
      ),
      padding: generalPadding,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: withBack
                      ? GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Row(
                            children: [
                              Container(
                                decoration: circleDecoration(
                                  color: MerathColors.white.withOpacity(0.1),
                                ),
                                padding: EdgeInsets.all(
                                  horizontalSpacing / 4,
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: MerathColors.white,
                                  size: horizontalSpacing,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ),
                TranslatedText(
                  title,
                  style: 'white18semi',
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions ?? [],
                  ),
                )
              ],
            ),
            if (actions == null) generalBox else generalSmallBox,
            Container(
              width: kDeviceWidth,
              decoration: cardDecoration(
                color: MerathColors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(
                  horizontalSpacing / 2,
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalSpacing / 2,
                vertical: verticalSpacing * 0.75,
              ),
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.search,
                    color: MerathColors.white,
                  ),
                  generalSmallBox,
                  Expanded(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        textSelectionTheme: const TextSelectionThemeData(
                          selectionColor: MerathColors.grey_80,
                        ),
                      ),
                      child: TextField(
                        onChanged: onSearchChange,
                        onTapOutside: (event) {
                          hideKeyboard();
                        },
                        style: textStyles['white18'],
                        controller: textEditingController,
                        onSubmitted: onSubmit,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: getWord('Search'),
                          hintStyle: textStyles['white18'],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
