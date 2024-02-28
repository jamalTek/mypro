import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'ui_helpers.dart';

Future<Response> downloadFile(String url, String outPutPath) async {
  final Dio dio = Dio();
  Response response = Response(requestOptions: RequestOptions());
  try {
    consoleLog('Downloading $url');
    response = await dio.download(
      url,
      outPutPath,
      onReceiveProgress: (count, total) {
        consoleLog(count / total);
      },
    );
  } on PlatformException catch (e) {
    consoleLog(e);
  }
  return response;
}
