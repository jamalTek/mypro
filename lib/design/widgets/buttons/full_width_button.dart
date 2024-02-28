import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';

class FullWidthButton extends StatelessWidget {
  const FullWidthButton({
    super.key,
    this.text = '',
    this.onPress,
    this.isOutline = false,
    this.isDisabled = false,
  });
  final String text;
  final void Function()? onPress;
  final bool isOutline;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    Function()? onButtonPress;
    if (isDisabled) {
      onButtonPress = null;
    } else {
      onButtonPress = onPress;
    }
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: onButtonPress,
      color: isOutline ? null : MerathColors.accent,
      disabledColor: MerathColors.grey_20,
      borderRadius: BorderRadius.circular(kDeviceWidth),
      child: AnimatedContainer(
        duration: generalAnimationDuration,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDeviceWidth),
          border: isOutline
              ? Border.all(
                  color: onButtonPress == null
                      ? MerathColors.grey_20
                      : MerathColors.accent,
                )
              : null,
        ),
        padding: EdgeInsets.symmetric(
          vertical: verticalSpacing * 0.75,
          horizontal: horizontalSpacing,
        ),
        width: kDeviceWidth,
        alignment: Alignment.center,
        child: TranslatedText(
          text,
          style: isOutline
              ? onButtonPress == null
                  ? 'grey14mid'
                  : 'primary14mid'
              : 'white14mid',
        ),
      ),
    );
  }
}
