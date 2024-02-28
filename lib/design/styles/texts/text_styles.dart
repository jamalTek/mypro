import 'dart:developer';

import '../../../general_exports.dart';

class MerathTextStyles {
  //** Welcome to the next level of text styling in flutter
  // in order to use all styles you just need to access to 'style' Map type variable
  // access any style by write '(colorName)(fontSize)[bold/semi]
  //
  // Examples:
  // - MerathTextStyles().style['white14']
  // - MerathTextStyles().style['white16bold']
  // - MerathTextStyles().style['grey18semi']
  //
  // *****************************************************/

  MerathTextStyles() {
    //** Defining default styles */
    defaultWhite = defaultTextStyle.copyWith(
      color: MerathColors.white,
    );
    defaultBlack = defaultTextStyle.copyWith(
      color: MerathColors.textColor,
    );
    defaultGrey = defaultTextStyle.copyWith(
      color: MerathColors.grey,
    );
    defaultPrimary = defaultTextStyle.copyWith(
      color: MerathColors.primary,
    );
    defaultAccent = defaultTextStyle.copyWith(
      color: MerathColors.accent,
    );
    defaultGold = defaultTextStyle.copyWith(
      color: MerathColors.goldEnd,
    );

    _textColors = [
      {
        kName: 'white',
        kDefaultStyle: defaultWhite,
      },
      {
        kName: 'black',
        kDefaultStyle: defaultBlack,
      },
      {
        kName: 'grey',
        kDefaultStyle: defaultGrey,
      },
      {
        kName: 'primary',
        kDefaultStyle: defaultPrimary,
      },
      {
        kName: 'accent',
        kDefaultStyle: defaultAccent,
      },
      {
        kName: 'gold',
        kDefaultStyle: defaultGold,
      },
    ];
    generateStyles();
  }
  Map<String, TextStyle> styles = {};
  List<Map<String, dynamic>> _textColors = [];

  //** Defaults Styles */
  static const TextStyle defaultTextStyle = TextStyle(fontFamily: 'SF');
  TextStyle defaultWhite = defaultTextStyle;
  TextStyle defaultBlack = defaultTextStyle;
  TextStyle defaultGrey = defaultTextStyle;
  TextStyle defaultPrimary = defaultTextStyle;
  TextStyle defaultAccent = defaultTextStyle;
  TextStyle defaultGold = defaultTextStyle;

  //** End of Defaults Styles */

  //////////////*****************************/////////////////

  /// Functions

  void createColorStyles({required int size}) {
    for (Map i in _textColors) {
      styles['${i[kName]}$size'] = i[kDefaultStyle].copyWith(
        fontSize: size.toDouble(),
      );
      styles['${i[kName]}${size}bold'] = i[kDefaultStyle].copyWith(
        fontSize: size.toDouble(),
        fontWeight: FontWeight.bold,
      );
      styles['${i[kName]}${size}semi'] = i[kDefaultStyle].copyWith(
        fontSize: size.toDouble(),
        fontWeight: FontWeight.w600,
      );
      styles['${i[kName]}${size}mid'] = i[kDefaultStyle].copyWith(
        fontSize: size.toDouble(),
        fontWeight: FontWeight.w500,
      );
    }
  }

  void generateStyles() {
    int startSize = 4;
    log('Defining text styles');
    for (int i = 0; i <= 30; i++) {
      createColorStyles(size: startSize);
      startSize += 1;
    }
  }
}
