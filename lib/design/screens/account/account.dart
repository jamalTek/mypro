import 'package:flutter/cupertino.dart';

import '../../../general_exports.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
      builder: (AccountController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context),
              Column(
                children: [
                  const Header(
                    title: 'Account',
                    withBack: true,
                  ),
                  Expanded(
                    child: Container(
                      decoration: cardDecoration(),
                      padding: generalPadding,
                      margin: generalPadding,
                      width: kDeviceWidth,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              'Welcome',
                              style: textStyles['black28mid'],
                            ),
                            Visibility(
                              visible: box.read(kUserData) == null,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: verticalSpacing / 2,
                                ),
                                child: FullWidthButton(
                                  text: 'Login',
                                  onPress: () {
                                    Get.offAllNamed(routeLogin);
                                  },
                                ),
                              ),
                            ),
                            generalBox,
                            ...controller.items.map(
                              (e) => Visibility(
                                visible: e[kIsVisible] ?? true,
                                child: AccountItem(item: e),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  generalBox,
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class AccountItem extends StatelessWidget {
  const AccountItem({
    super.key,
    required this.item,
  });
  final Map item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item[kOnPress],
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: circleDecoration(
                    color: MerathColors.shapeBackground,
                  ),
                  padding: EdgeInsets.all(horizontalSpacing / 2),
                  width: horizontalSpacing * 2.3,
                  height: horizontalSpacing * 2.3,
                  child: BasicSvg(
                    item[kIcon],
                    color: item[kColor] ?? MerathColors.textColor,
                  ),
                ),
                generalBox,
                TranslatedText(
                  item[kTitle],
                  style: textStyles['black16']!.copyWith(color: item[kColor]),
                ),
                const Spacer(),
                const Icon(
                  CupertinoIcons.arrow_left,
                )
              ],
            ),
            Divider(
              height: verticalSpacing * 1.5,
            )
          ],
        ),
      ),
    );
  }
}
