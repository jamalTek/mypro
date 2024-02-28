import 'package:flutter_animate/flutter_animate.dart';

import '../../../general_exports.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (LoginController controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              getBackground(context, superLight: false),
              Center(
                child: Container(
                  decoration: cardDecoration(),
                  margin: generalPadding,
                  padding: generalPadding,
                  child: AnimatedSize(
                    duration: controller.animationDuration,
                    curve: controller.animationCurve,
                    child: controller.currentWindow,
                  ),
                )
                    .animate()
                    .fade(
                      curve: Curves.easeOut,
                      delay: const Duration(milliseconds: 100),
                    )
                    .move(),
              )
            ],
          ),
        );
      },
    );
  }
}
