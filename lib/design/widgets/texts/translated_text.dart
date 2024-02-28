import 'package:flutter/material.dart';

import '../../../logic/constants/global.dart';
import '../../../logic/helpers/ui_helpers.dart';

class TranslatedText extends StatelessWidget {
  const TranslatedText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });
  final dynamic text;
  final dynamic style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: text != null,
      child: Text(
        getWord(text.toString()),
        style: style is TextStyle ? style : textStyles[style],
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
