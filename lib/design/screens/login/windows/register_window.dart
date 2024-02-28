import 'package:flutter_animate/flutter_animate.dart';

import '../../../../general_exports.dart';

class RegisterWindow extends StatelessWidget {
  const RegisterWindow({
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
                  onTap: controller.onForgetPasswordBack,
                  child: const SmallCircleBackButton(),
                ),
                generalSmallBox,
                const TranslatedText(
                  'Register',
                  style: 'black18semi',
                ),
              ],
            ),
            generalSmallBox,
            const TranslatedText(
              'Welcome to the Merath alnabi, please fill in your details to log in',
              style: 'grey12',
            ),
            generalBox,
            const TranslatedText(
              'User name',
              style: 'black12',
            ),
            generalSmallBox,
            CTextInput(
              hint: getWord('User name'),
              controller: controller.userNameController,
              onChange: (v) {
                controller.update();
              },
            ),
            generalBox,
            const TranslatedText(
              'Email',
              style: 'black12',
            ),
            generalSmallBox,
            CTextInput(
              hint: getWord('name@mail.com'),
              controller: controller.emailController,
              onChange: (v) {
                controller.update();
              },
            ),
            generalBox,
            const TranslatedText(
              'Password',
              style: 'black12',
            ),
            generalSmallBox,
            CTextInput(
              hint: getWord('Password'),
              controller: controller.passwordController,
              onChange: (v) {
                controller.update();
              },
            ),
            generalBox,
            Row(
              children: [
                SizedBox(
                  width: horizontalSpacing * 1,
                  height: verticalSpacing,
                  child: Checkbox(
                    value: controller.agreedTerms,
                    onChanged: controller.termsToggle,
                  ),
                ),
                generalSmallBox,
                const TranslatedText(
                  'Agree to the terms and conditions',
                  style: 'black14',
                ),
              ],
            ),
            generalBox,
            FullWidthButton(
              text: getWord('Confirm'),
              onPress: controller.onRegisterConfirm,
              isDisabled: !controller.registerAvailable(),
            ),
          ],
        ).animate(effects: controller.animationEffects);
      },
    );
  }
}
