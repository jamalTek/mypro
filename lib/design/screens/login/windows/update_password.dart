import 'package:flutter_animate/flutter_animate.dart';

import '../../../../general_exports.dart';

class UpdatePasswordWindow extends StatelessWidget {
  const UpdatePasswordWindow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (LoginController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                // const SmallCircleBackButton(),
                // generalSmallBox,
                TranslatedText(
                  'Forget password',
                  style: 'black18semi',
                ),
              ],
            ),
            generalSmallBox,
            const TranslatedText(
              'Pleas enter your email',
              style: 'grey12',
            ),
            generalBox,
            const TranslatedText(
              'New password',
            ),
            generalSmallBox,
            CTextInput(
                hint: getWord('Password'),
                controller: controller.newPasswordController,
                onChange: (v) {
                  controller.update();
                }),
            generalBox,
            const TranslatedText(
              'Confirm new password',
            ),
            generalSmallBox,
            CTextInput(
              hint: getWord('Password'),
              controller: controller.confirmPasswordController,
              onChange: (v) {
                controller.update();
              },
            ),
            generalBox,
            generalBox,
            FullWidthButton(
              text: getWord('Confirm'),
              onPress: controller.onPasswordConfirm,
              isDisabled: !(controller.newPasswordController.text.length > 4 &&
                  controller.confirmPasswordController.text.length > 4 &&
                  controller.newPasswordController.text ==
                      controller.confirmPasswordController.text),
            ),
          ],
        ).animate(effects: controller.animationEffects);
      },
    );
  }
}
