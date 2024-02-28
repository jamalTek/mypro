import '../../../general_exports.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    this.actions,
    this.withBack = false,
    required this.title,
  });
  final List<Widget>? actions;
  final bool withBack;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(horizontalSpacing * 2),
        ),
        color: MerathColors.primary,
      ),
      padding: generalPadding,
      child: SafeArea(
        bottom: false,
        child: Row(
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
              style: textStyles['white18semi'],
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
