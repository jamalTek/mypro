import 'package:webview_flutter/webview_flutter.dart';

import '../../../general_exports.dart';

class WebScreenController extends GetxController {
  String link = 'www.google.com';

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(MerathColors.background)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..setBackgroundColor(MerathColors.shapeBackgroundLight)
    ..loadRequest(Uri.parse(Get.arguments[kUrl]));

  @override
  void onInit() {
    super.onInit();
    link = Get.arguments[kUrl];
  }
}
