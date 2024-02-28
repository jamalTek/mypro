import '../constants/global.dart';

String baseUrl = currentMode == AppMode.dev
    ? 'https://merath-alnabi.com/api/'
    : currentMode == AppMode.demo
        ? 'https://merath-alnabi.com/api/'
        : 'https://merath-alnabi.com/api/';

const String postMethod = 'post';
const String getMethod = 'get';
const String putMethod = 'put';
const String deleteMethod = 'delete';
const String patchMethod = 'patch';
