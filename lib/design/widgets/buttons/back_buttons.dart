import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';

class SmallCircleBackButton extends StatelessWidget {
  const SmallCircleBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: circleDecoration(
        color: MerathColors.accent.withOpacity(0.4),
      ),
      padding: const EdgeInsets.all(4),
      child: Icon(
        CupertinoIcons.back,
        size: horizontalSpacing / 1.5,
        color: MerathColors.primary,
      ),
    );
  }
}

class BackButtonC extends StatelessWidget {
  const BackButtonC({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Get.back();
      },
      padding: EdgeInsets.zero,
      minSize: 0,
      child: Container(
        decoration: circleDecoration(
          color: MerathColors.accent.withOpacity(0.3),
        ),
        padding: EdgeInsets.all(horizontalSpacing / 3),
        child: Icon(
          Icons.arrow_back,
          color: MerathColors.primary,
          size: horizontalSpacing * 1.3,
        ),
      ),
    );
  }
}
