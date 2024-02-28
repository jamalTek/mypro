import '../../../general_exports.dart';

class QuickAccess extends StatelessWidget {
  const QuickAccess({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardDecoration(),
      padding: generalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TranslatedText(
            'Quick access',
            style: 'black18semi',
          ),
          generalBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...controller.fastAccess.map(
                (e) {
                  final int index = controller.fastAccess.indexOf(e);
                  return GestureDetector(
                    onTap: e[kOnPress],
                    child: Container(
                      decoration: cardDecoration(
                        color: (index % 3 == 1
                                ? MerathColors.accent
                                : index % 3 == 2
                                    ? MerathColors.thirdly
                                    : MerathColors.primary)
                            .withOpacity(0.1),
                      ),
                      width: horizontalSpacing * 5,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: verticalSpacing * 1.2,
                        horizontal: horizontalSpacing / 3,
                      ),
                      child: FittedBox(
                        child: TranslatedText(
                          e[kTitle],
                          style: 'black12mid',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
