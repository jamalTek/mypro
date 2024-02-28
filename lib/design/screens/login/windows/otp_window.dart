import 'package:flutter_animate/flutter_animate.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../general_exports.dart';

class OTPWindow extends StatelessWidget {
  const OTPWindow({
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
                  onTap: controller.onOtpBack,
                  child: const SmallCircleBackButton(),
                ),
                generalSmallBox,
                const TranslatedText(
                  'Code verification',
                  style: 'black18semi',
                ),
              ],
            ),
            generalSmallBox,
            const TranslatedText(
              'Please type the code sent to you via e-mail',
              style: 'grey12',
            ),
            generalBox,
            Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: SizedBox(
                  width: kDeviceWidth * 0.7,
                  child: PinCodeTextField(
                    length: 4,

                    animationType: AnimationType.scale,
                    autoFocus: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius:
                          BorderRadius.circular(horizontalSpacing / 2),
                      fieldHeight: horizontalSpacing * 2.9,
                      fieldWidth: horizontalSpacing * 2.9,
                      activeFillColor: MerathColors.shapeBackground,
                      inactiveFillColor: MerathColors.shapeBackground,
                      errorBorderColor: MerathColors.white,
                      inactiveColor: MerathColors.white,
                      activeColor: MerathColors.white,
                      selectedFillColor: MerathColors.white,
                      disabledColor: MerathColors.white,
                      selectedColor: MerathColors.primary,
                    ),
                    textStyle: textStyles['black18semi'],
                    animationDuration: const Duration(milliseconds: 400),
                    enableActiveFill: true,
                    appContext: context,
                    onCompleted: controller.onOtpComplete,
                    onChanged: controller.onOtpChange,
                    autoDisposeControllers: false,
                    controller: controller.otpController,
                    // beforeTextPaste: (text) {
                    //   log('Allowing to paste $text');
                    //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    //   return true;
                    // },
                  ),
                ),
              ),
            ),
            generalSmallBox,
            Center(
              child: TranslatedText(
                'Resend the code',
                style: textStyles['primary14mid']?.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            generalBox,
            generalBox,
            FullWidthButton(
              text: getWord('Verify'),
              onPress: controller.onOTPVerify,
              isDisabled: controller.otpController.text.length < 4,
            )
          ],
        ).animate(effects: controller.animationEffects);
      },
    );
  }
}
