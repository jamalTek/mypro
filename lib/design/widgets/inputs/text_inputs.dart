import 'package:flutter/services.dart';

import '../../../general_exports.dart';

class CTextInput extends StatelessWidget {
  const CTextInput({
    super.key,
    this.hint,
    this.onChange,
    this.suffixIcon,
    this.maxLength = 200,
    this.isPassword = false,
    this.isSmall = false,
    this.controller,
    this.minLines,
    this.maxLines,
    this.inputType,
    this.suffix,
    this.suffixText,
    this.suffixStyle,
  });
  final String? hint;
  final void Function(String v)? onChange;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? suffixText;
  final int maxLength;
  final bool isPassword;
  final bool isSmall;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final TextInputType? inputType;
  final TextStyle? suffixStyle;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      obscureText: isPassword,
      minLines: minLines,
      keyboardType: inputType,
      onTapOutside: (event) {
        hideKeyboard();
      },
      maxLines: maxLines ?? 1,
      inputFormatters: [
        if (TextInputType.number == inputType)
          FilteringTextInputFormatter.digitsOnly
      ],
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: textStyles['grey14'],
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: MerathColors.greenEnd,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalSpacing / 2,
          vertical: isSmall ? verticalSpacing / 2 : verticalSpacing,
        ),
        suffixIcon: suffixIcon,
        suffix: suffix,
        suffixText: suffixText,
        suffixStyle: suffixStyle,
        counterText: '',
        suffixIconConstraints: const BoxConstraints(),
        isCollapsed: true,
      ),
      cursorColor: MerathColors.greenEnd,
      maxLength: maxLength,
    );
  }
}
