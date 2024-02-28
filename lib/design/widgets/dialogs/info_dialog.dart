import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    super.key,
    required this.icon,
    required this.text,
    this.color,
  });
  final String icon;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MerathColors.shapeBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(horizontalSpacing),
      ),
      child: Stack(
        children: [
          Container(
            padding: generalPadding,
            width: kDeviceWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                generalBox,
                BasicSvg(
                  icon,
                  width: kDeviceWidth * 0.3,
                  color: color,
                ),
                generalBox,
                TranslatedText(
                  text,
                  style: textStyles['primary20'],
                ),
                generalBox,
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: CupertinoButton(
              child: Icon(
                CupertinoIcons.xmark,
                color: MerathColors.textColor,
                size: horizontalSpacing,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget successDialog = const InfoDialog(
  icon: Assets.assetsIconsChecked,
  text: 'Added successfully',
);
