import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (SplashController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context, superLight: false),
              Center(
                child: SvgPicture.asset(
                  Assets.assetsIconsSplashLogo,
                )
                    .animate()
                    .slide(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutBack,
                    )
                    .scale(),
              ),
            ],
          ),
        );
      },
    );
  }
}
