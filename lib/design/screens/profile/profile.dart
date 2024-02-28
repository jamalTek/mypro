import '../../../general_exports.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (ProfileController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context),
              Column(
                children: [
                  const Header(
                    title: 'Profile',
                    withBack: true,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        hideKeyboard();
                      },
                      child: Container(
                        decoration: cardDecoration(),
                        padding: generalPadding,
                        margin: generalPadding,
                        width: kDeviceWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              'Manage your data',
                              style: textStyles['black28mid'],
                            ),
                            generalBox,
                            TranslatedText(
                              'User name',
                              style: textStyles['black12'],
                            ),
                            generalSmallBox,
                            CTextInput(
                              isSmall: true,
                              controller: controller.userNameController,
                            ),
                            generalBox,
                            TranslatedText(
                              'Email',
                              style: textStyles['black12'],
                            ),
                            generalSmallBox,
                            CTextInput(
                              isSmall: true,
                              controller: controller.emailController,
                            ),
                            const Spacer(),
                            FullWidthButton(
                              text: 'Save changes',
                              onPress: controller.onSavedChange,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
