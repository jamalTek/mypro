import 'package:flutter_animate/flutter_animate.dart';

import '../../../../general_exports.dart';

class ForgetPasswordWindow extends StatelessWidget {
  const ForgetPasswordWindow({
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
              children: [
                GestureDetector(
                  onTap: controller.onRegisterBack,
                  child: const SmallCircleBackButton(),
                ),
                generalSmallBox,
                const TranslatedText(
                  'Forget Password',
                  style: 'black18semi',
                ),
              ],
            ),
            generalSmallBox,
            const TranslatedText(
              'Please type the previously registered e-mail to recover the password',
              style: 'grey12',
            ),
            generalBox,
            const TranslatedText(
              'Email',
            ),
            generalSmallBox,
            CTextInput(
              hint: getWord('Email'),
              inputType: TextInputType.emailAddress,
              controller: controller.emailController,
              onChange: (v) {
                controller.update();
              },
            ),
            generalBox,
            generalBox,
            FullWidthButton(
              text: getWord('Send'),
              onPress: controller.sendOTP,
              isDisabled: !controller.emailController.text.isEmail,
            ),
          ],
        ).animate(effects: controller.animationEffects);
      },
    );
  }
}
