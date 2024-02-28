import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BasicSvg extends StatelessWidget {
  const BasicSvg(
    this.asset, {
    super.key,
    this.color,
    this.height,
    this.width,
    this.fit,
  });
  final String asset;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
    );
  }
}
