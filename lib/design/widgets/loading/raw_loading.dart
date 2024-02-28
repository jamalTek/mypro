import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../general_exports.dart';

class RawLoading extends StatelessWidget {
  const RawLoading({
    super.key,
    this.loadingText,
  });

  final String? loadingText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SpinKitWaveSpinner(
          color: MerathColors.primary,
          trackColor: MerathColors.greenEnd,
          size: horizontalSpacing * 3,
          waveColor: MerathColors.primary,
          duration: const Duration(seconds: 2),
        ),
        generalSmallBox,
        FittedBox(
          fit: BoxFit.none,
          child: TranslatedText(
            loadingText ?? 'Loading',
            style: 'black16',
          ),
        )
      ],
    );
  }
}
