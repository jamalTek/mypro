import 'package:webview_flutter/webview_flutter.dart';

import '../../../general_exports.dart';

class WebScreen extends StatelessWidget {
  const WebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebScreenController>(
      init: WebScreenController(),
      builder: (WebScreenController controller) {
        return Scaffold(
          body: Stack(
            children: [
              getBackground(context),
              Column(
                children: [
                  Header(
                    title: Get.arguments[kTitle] ?? '',
                    withBack: true,
                  ),
                  Expanded(
                    child: Container(
                      decoration: cardDecoration(
                          color: MerathColors.shapeBackgroundLight),
                      padding: generalPadding,
                      margin: generalPadding,
                      child: WebViewWidget(controller: controller.controller),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
