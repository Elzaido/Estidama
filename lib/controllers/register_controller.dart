// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';

import '../db/local/shared_preference.dart';

class RegisterController extends GetxController {
  List<String> provinces = [
    "اربد",
    "الزرقاء",
    "عمان",
    "مأدبا",
    "جرش",
    "عجلون",
    'معان',
    "المفرق",
    "العقبة",
    "البلقاء",
    "الكرك",
    "الطفيلة"
  ];

  Map<int, String> provincesx = {
    1: "اربد",
    2: "الزرقاء",
    3: "عمان",
    4: "مأدبا",
    5: "جرش",
    6: "عجلون",
    7: 'معان',
    8: "المفرق",
    9: "العقبة",
    10: "البلقاء",
    11: "الكرك",
    12: "الطفيلة"
  };

  RxString selectedProvince = "عمان".obs;
  RxString gender = "".obs;
  //in getx this is how we declare variables that are listenable

  changeProvince(newValue) => selectedProvince.value = newValue;
//Future update
  changeGender() => gender.value == "male" ? gender.value = "female" : "male";

  //BEFORE YOU BEGIN PLEASE NOTICE THIS:
  // PROVINCES IN DATABASE ARE IN ENGLISH  AND HAVE NDECIES : {IRBID: 1 ,AMMAN: 2}....
  //WE NEED TO SEND THE PROVINCE ID WHICH IS A STRING (PREFERABLE )  TO THE RESPONSE
  //THIS HELPS IN PUTTING MULI LANGAUGE LIKE ARABIC OR CHINEES...
  String iterateUserProvince(String province) {
    //THIS FUNCTION IS USED TO LOOP ON THE PROVINCES
    // AND GET KEYS TO SAVE WITH THE CREDENTIALS
    int key = 0;

    provincesx.forEach((k, v) {
      if (v == province) {
        key = k;
        return;
      }
    });
    return key.toString();
  }

  Future<void> saveCredentials({
    required String user_name,
    required String user_phone,
    required String user_province,
    required String gender,
    required String user_password,
  }) async {
    // Save credentials logic here.
    DateTime get_current_date = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the current date using the DateFormat object.
    String formattedDate = dateFormat.format(get_current_date);
    log(formattedDate.toString());
    var response = await postRequest(signUpLink, {
      "join_date": formattedDate,
      "password": user_password,
      "gender": gender,
      "number": user_phone,
      "name": user_name,
      "province": iterateUserProvince(user_province),
      "status": "online"
    });
    //STATUS IS CHANGEABLE :ONCE THE USER SIGNS UP THIS MEANS HE IS ONLINE
    //, ONCE HE SIGNS OUT OR EXIT APP IT MEANS HIS OFFILINE

    if (response['status'] == "faild") {
      defaultToast(
          massage: "لم يتم انشاء حساب يرجى التأكد من الحقول",
          state: ToastStates.ERROR);
    }

    if (response['status'] == "success") {
      defaultToast(
          massage: 'تم تسجيل الدخول بنجاح', state: ToastStates.SUCCESS);
      CacheHelper.saveData(key: "isLogin", value: true);
      CacheHelper.saveData(key: "uId", value: "1"); //will do it later

      Get.offAllNamed("/launcher"); //go to laucnher
    }
    if (response['account_exists'] == "yes") {
      defaultToast(
          massage: "! الحساب موجود مسبقا الرجاء استخدام رقمك الشخصي",
          state: ToastStates.ERROR);
    }
    return response;
  }

  void signUpProcess(String user_name, String user_phone, String user_province,
      String gender, String user_password) {
    log('$selectedProvince');
    if (user_name.isEmpty ||
        user_phone.isEmpty ||
        user_province.isEmpty ||
        gender.isEmpty ||
        user_password.isEmpty) {
      defaultToast(massage: '! تأكد من الحقول', state: ToastStates.ERROR);
    } else {
      saveCredentials(
        user_name: user_name,
        user_phone: user_phone,
        user_province: user_province,
        gender: gender,
        user_password: user_password,
      );
    }
  }
}
