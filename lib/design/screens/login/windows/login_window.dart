import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../general_exports.dart';

class LoginWindow extends StatelessWidget {
  const LoginWindow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (LoginController controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // generalSmallBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const TranslatedText(
                  'Login',
                  style: 'black18semi',
                ),
                CupertinoButton(
                  minSize: 0,
                  padding: EdgeInsets.only(
                    right: horizontalSpacing,
                    top: verticalSpacing / 2,
                    bottom: verticalSpacing / 2,
                  ),
                  onPressed: () {
                    box.write(kIsSkipped, true);
                    Get.offAllNamed(routeMain);
                  },
                  child: const TranslatedText(
                    'Skip',
                    style: 'grey18semi',
                  ),
                ),
              ],
            ),
            // generalSmallBox,
            const TranslatedText(
              'Welcome to the Merath alnabi, please fill in your details to log in',
              style: 'grey12',
            ),
            generalBox,
            const TranslatedText(
              'Email',
              style: 'black12',
            ),
            generalSmallBox,
            CTextInput(
                hint: 'someone@mail.com',
                controller: controller.emailController,
                onChange: (v) {
                  controller.update();
                }),
            generalSmallBox,
            const TranslatedText(
              'Password',
              style: 'black12',
            ),
            generalSmallBox,
            CTextInput(
              hint: getWord('Password'),
              inputType: TextInputType.emailAddress,
              suffixIcon: GestureDetector(
                onTap: controller.toggleShowPassword,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                  child: Icon(controller.showPassword
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash),
                ),
              ),
              isPassword: !controller.showPassword,
              controller: controller.passwordController,
              maxLines: 1,
              onChange: (v) {
                controller.update();
              },
            ),
            generalSmallBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: controller.onForgetPasswordPress,
                  child: const TranslatedText('Forget Password'),
                )
              ],
            ),
            generalBox,
            FullWidthButton(
              text: 'Login',
              onPress: controller.onLoginPress,
              isDisabled: !(controller.emailController.text.isEmail &&
                  controller.passwordController.text.length > 4),
            ),
            generalBox,
            FullWidthButton(
              text: 'Register',
              isOutline: true,
              onPress: controller.onRegisterPress,
            ),
            generalBox,
            Container(
              height: 4,
              decoration: cardDecoration(
                color: MerathColors.grey_10,
              ),
            ),
            generalBox,
            const Center(
              child: TranslatedText(
                'Or register Throw',
                style: 'black14',
              ),
            ),
            generalBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...controller.socials.map(
                  (e) => GestureDetector(
                    onTap: e[kOnPress],
                    child: Container(
                      width: horizontalSpacing * 2.2,
                      height: horizontalSpacing * 2.2,
                      margin: EdgeInsets.symmetric(
                        horizontal: horizontalSpacing / 2,
                      ),
                      decoration: circleDecoration(color: MerathColors.primary),
                      child: Icon(
                        e[kIcon],
                        color: MerathColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            generalSmallBox,
          ],
        ).animate(effects: controller.animationEffects);
      },
    );
  }
}
