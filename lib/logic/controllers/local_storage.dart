import 'package:get_storage/get_storage.dart';

import '../../general_exports.dart';

class LocalStorage extends GetxController {
  GetStorage storage = GetStorage();

  void write(String key, dynamic value) {
    storage.write(key, value);
  }

  void writeIfNull(String key, dynamic value) {
    storage.writeIfNull(key, value);
  }

  dynamic read(String key) {
    return storage.read(key);
  }

  bool isExist(String key) {
    return storage.read(key) != null;
  }
}
