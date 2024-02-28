import 'package:flutter_animate/flutter_animate.dart';

import '../../../../general_exports.dart';

class LoadingWindow extends StatelessWidget {
  const LoadingWindow({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: generalPadding,
      width: kDeviceWidth,
      //height: kDeviceHeight * 0.2,
      child: RawLoading(
        loadingText: text ?? 'Loading',
      ),
    ).animate(effects: [
      const MoveEffect(),
      const FadeEffect(),
    ]);
  }
}
