import '../../../general_exports.dart';
import '../../widgets/dialogs/info_dialog.dart';

class ProfileController extends GetxController {
  TextEditingController userNameController =
      TextEditingController(text: box.read(kUserData)[kName]);
  TextEditingController emailController =
      TextEditingController(text: box.read(kUserData)[kEmail]);

  void onSavedChange() {
    ApiRequest(
      path: apiUser,
      method: putMethod,
      body: {
        kName: userNameController.text,
        kEmail: emailController.text,
      },
    ).request(
      onSuccess: (data, response) {
        Get.dialog(successDialog);
        Get.find<UserController>().updateUserData(data);
      },
    );
  }
}
