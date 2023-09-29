import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/ui/pages/authentication/auth_success.dart';
import '../ui/widgets/toast_widget.dart';

///THIS IS THE LOGIN PAGE CONTROLLER IT HAS ON SUBMIT LOGIN WHICH CHECKS IF CREDENTIALS ARE
///RIGHT THEN IT GOES TO LOGIN REQUEST FUNCTION WHICH  MAKES A REQUEST TO ZAMELSTUDIOS .COM
/// ITS A POST REQUEST AND HAS 2 PARAMETERS : COUNTR.PHONE AND PASSWORD OF USER
class LoginController extends GetxController {
  RxBool isScure = true.obs;
  RxBool isLoading = false.obs;

  void changeIsScure() {
    isScure.value = !isScure.value;
  }

  loginRequest(phone, country, password) async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token;

    try {
      token = await firebaseMessaging.getToken();
      print('FCM Token: $token');
    } catch (error) {
      print('Error getting FCM token: $error');
    }

    var response = await postRequest(loginPageLink, {
      "number": phone,
      "password": "$password",
      "new_token": token.toString(),
    });
    //only for testing purposes number is: 4365345, password is 11111111

    if (response['auth_status'] == "wrong" || response['status'] == "faild") {
      defaultToast(
          massage: "لم يتم تسحيل الدخول يرجى التأكد من الحقول",
          state: ToastStates.ERROR);
    }
    if (response['status'] == "success") {
      onSuccessfulUserAuth(response, "تم تسجيل الدخول بنجاح");
    }
    isLoading.value = false;
    return response;
  }

  void onSubmitLogin(phoneControl, countryControl, passControl, context) {
    isLoading.value = true;
    if (phoneControl != "" && countryControl != "" && passControl != "") {
      loginRequest(phoneControl, countryControl, passControl);
    } else {
      defaultToast(massage: 'الرجاء ملئ الحقول', state: ToastStates.ERROR);
    }
  }
}
