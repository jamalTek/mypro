// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../../general_exports.dart';
import 'windows/index.dart';

class LoginController extends GetxController {
  List socials = [];

  Widget currentWindow = const LoginWindow();
  Duration animationDuration = const Duration(milliseconds: 500);
  Curve animationCurve = Curves.easeOutBack;
  List<Effect> animationEffects = [];
  bool showPassword = false;
  bool agreedTerms = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    animationEffects = [
      MoveEffect(
        duration: animationDuration,
        curve: animationCurve,
      ),
      const FadeEffect(),
    ];
    socials = [
      {
        kIcon: FontAwesomeIcons.apple,
        kOnPress: singInWithApple,
      },
      {
        kIcon: FontAwesomeIcons.twitter,
        kOnPress: signInWithTwitter,
      },
      {
        kIcon: FontAwesomeIcons.google,
        kOnPress: signInWithGoogle,
      },
      {
        kIcon: FontAwesomeIcons.facebook,
        kOnPress: signInWithFacebook,
      },
    ];
  }

  void toggleShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void updateCurrentWindow(Widget widget) {
    currentWindow = widget;
    update();
  }

  void onLoginPress() {
    updateCurrentWindow(const LoadingWindow());
    final Map<String, String> body = {
      kEmail: emailController.text,
      kPassword: passwordController.text
    };
    ApiRequest(
      path: apiLogin,
      method: postMethod,
      body: body,
    ).request(
      onSuccess: (data, response) async {
        consoleLog(data);
        final UserController userController = Get.find<UserController>();
        consoleLog(box.read(kUserData));
        data[kEmail] = body[kEmail];
        consoleLog(data);
        userController.updateUserData(data);
        Get.offAllNamed(routeMain);
      },
      onError: (error) {
        updateCurrentWindow(const LoginWindow());
      },
    );
  }

  void onRegisterPress() {
    updateCurrentWindow(const RegisterWindow());
    update();
  }

  //** Register Section */

  void onRegisterBack() {
    updateCurrentWindow(const LoginWindow());
  }

  void termsToggle(bool? v) {
    agreedTerms = v ?? !agreedTerms;
    update();
  }

  bool registerAvailable() {
    return userNameController.text.length > 3 &&
        emailController.text.isEmail &&
        passwordController.text.length > 4 &&
        agreedTerms;
  }

  void onRegisterConfirm() {
    updateCurrentWindow(const LoadingWindow());
    ApiRequest(
      path: apiRegister,
      method: postMethod,
      body: {
        kName: userNameController.text,
        kEmail: emailController.text,
        kPassword: passwordController.text,
      },
    ).request(
      onSuccess: (data, response) {
        consoleLog(data);
        Get.offAllNamed(routeMain);
      },
      onError: (error) {
        updateCurrentWindow(const RegisterWindow());
      },
    );
  }

  //** Forget Password Section */
  void onForgetPasswordBack() {
    updateCurrentWindow(const LoginWindow());
  }

  void onForgetPasswordPress() {
    updateCurrentWindow(const ForgetPasswordWindow());
    update();
  }

  void sendOTP() {
    updateCurrentWindow(const LoadingWindow());
    ApiRequest(method: postMethod, path: apiForgotPassword, body: {
      kEmail: emailController.text,
    }).request(
      onSuccess: (data, response) {
        updateCurrentWindow(const OTPWindow());
        update();
      },
    );
    // Future.delayed(const Duration(seconds: 3)).then((value) {
    //   updateCurrentWindow(const OTPWindow());
    //   update();
    // });
  }

  //** OTP Section */

  TextEditingController otpController = TextEditingController();

  void onOtpBack() {
    updateCurrentWindow(const ForgetPasswordWindow());
    update();
  }

  void onOtpChange(String pin) {
    update();
  }

  void onOtpComplete(String pin) {
    update();
    hideKeyboard();
    onOTPVerify();
  }

  void onOTPVerify() {
    hideKeyboard();
    ApiRequest(
      path: apiValidateCode,
      method: postMethod,
      body: {'code': otpController.text},
    ).request(
      onSuccess: (data, response) {
        updateCurrentWindow(const UpdatePasswordWindow());
      },
    );
    update();
  }

  //** Update Password  Section */

  void onPasswordBack() {
    updateCurrentWindow(const OTPWindow());
    update();
  }

  void onPasswordConfirm() {
    ApiRequest(
      path: apiResetPassword,
      method: postMethod,
      body: {
        'code': otpController.text,
        kPassword: newPasswordController.text,
        'password_confirmation': confirmPasswordController.text,
      },
    ).request(
      onSuccess: (data, response) {
        updateCurrentWindow(const LoginWindow());
        newPasswordController.clear();
        confirmPasswordController.clear();
        passwordController.clear();
        otpController.clear();
      },
    );

    update();
  }

//   ///** Social Media Sections */
//   ///
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
            clientId:
                '664786675879-m5j8ur5hshk95armq011jfljacfeence.apps.googleusercontent.com')
        .signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    if (googleAuth?.accessToken == null) {
      return;
    }
    ApiRequest(
      path: apiGoogle,
      method: postMethod,
      body: {
        kAccessToken: googleAuth?.accessToken,
      },
    ).request(
      onSuccess: (data, response) {
        consoleLog(data);
        final UserController userController = Get.find<UserController>();
        consoleLog(box.read(kUserData));
        data[kEmail] = googleUser?.email;
        consoleLog(data);
        userController.updateUserData(data);
        Get.offAllNamed(routeMain);
      },
    );
  }

  Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    // final OAuthCredential facebookAuthCredential =
    //     FacebookAuthProvider.credential(loginResult.accessToken!.token);
    // await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    ApiRequest(
      path: apFacebook,
      method: postMethod,
      body: {
        kAccessToken: loginResult.accessToken!.token,
      },
    ).request(
      onSuccess: (data, response) {
        consoleLog(data);
        final UserController userController = Get.find<UserController>();
        consoleLog(box.read(kUserData));
        //data[kEmail] = FirebaseAuth.instance.currentUser!.email;
        consoleLog(data);
        userController.updateUserData(data);
        Get.offAllNamed(routeMain);
      },
    );
  }

  Future<void> signInWithTwitter() async {
    // Create a TwitterLogin instance

    final twitterLogin = TwitterLogin(
      apiKey: 'KtXAGLiypjEOLott4lek59IkH',
      apiSecretKey: 'qA92dO8MpGAeL9TNEBIJCBQjWlA7dJDrSYpuKoIZnQb984TxDE',
      redirectURI: 'merath://',
    );

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();
    consoleLog(authResult.authToken);
    consoleLog(authResult.authTokenSecret);

    // Create a credential from the access token
    // final twitterAuthCredential = TwitterAuthProvider.credential(
    //   accessToken: authResult.authToken!,
    //   secret: authResult.authTokenSecret!,
    // );
    //await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);

    ApiRequest(
      path: apiTwitter,
      method: postMethod,
      body: {
        kAuthToken: authResult.authToken,
        kAuthSecret: authResult.authTokenSecret,
      },
    ).request(
      onSuccess: (data, response) {
        consoleLog(data);
        final UserController userController = Get.find<UserController>();
        consoleLog(box.read(kUserData));
        //data[kEmail] = FirebaseAuth.instance.currentUser!.email;
        consoleLog(data);
        userController.updateUserData(data);
        Get.offAllNamed(routeMain);
      },
    );

    // Once signed in, return the UserCredential
  }

  Future<void> singInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    print(credential.identityToken);
    print(credential.email);
    print(credential.givenName);
    final Map<String, dynamic> body = {
      kAccessToken: credential.identityToken,
    };
    if (credential.givenName != null && credential.familyName != null) {
      body[kName] =
          '${credential.givenName ?? ''} ${credential.familyName ?? ''}';
    }
    ApiRequest(
      path: apiApple,
      method: postMethod,
      body: body,
    ).request(
      onSuccess: (data, response) {
        consoleLog(data);
        final UserController userController = Get.find<UserController>();
        consoleLog(box.read(kUserData));
        data[kEmail] = credential.email;
        consoleLog(data);
        userController.updateUserData(data);
        Get.offAllNamed(routeMain);
      },
    );
  }
}
