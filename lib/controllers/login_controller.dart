import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/local/shared_preference.dart';
import 'package:madenati/db/remote/sql.dart';
import '../ui/widgets/toast_widget.dart';

///THIS IS THE LOGIN PAGE CONTROLLER IT HAS ON SUBMIT LOGIN WHICH CHECKS IF CREDENTIALS ARE
///RIGHT THEN IT GOES TO LOGIN REQUEST FUNCTION WHICH  MAKES A REQUEST TO ZAMELSTUDIOS .COM
/// ITS A POST REQUEST AND HAS 2 PARAMETERS : COUNTR.PHONE AND PASSWORD OF USER
class LoginController extends GetxController {
  loginRequest(phone, country, password) async {
    var response = await postRequest(
        loginPageLink, {"number": '$phone', "password": "$password"});
    //only for testing purposes number is: 12345678, password is 11111111
    CacheHelper.saveDate(key: "isLogin", value: true);

    if (response['auth_status'] == "wrong" || response['status'] == "faild") {
      defaultToast(
          massage: "لم يتم تسحيل الدخول يرجى التأكد من الحقول",
          state: ToastStates.ERROR);
    }
    if (response['status'] == "success") {
      defaultToast(
          massage: 'تم تسجيل الدخول بنجاح', state: ToastStates.SUCCESS);

      Get.offAllNamed("/launcher"); //go to laucnher
    }
    return response;
  }

  void onSubmitLogin(phoneControl, countryControl, passControl, context) {
    if (phoneControl != "" && countryControl != "" && passControl != "") {
      loginRequest(phoneControl, countryControl, passControl);
    } else {
      defaultToast(massage: 'الرجاء ملئ الحقول', state: ToastStates.ERROR);
    }
  }
}
