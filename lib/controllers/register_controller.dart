// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/ui/pages/authentication/auth_success.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';

class RegisterController extends GetxController {
  RxBool isScure = true.obs;
  RxBool isLoading = false.obs;
  void changeIsScure() {
    isScure.value = !isScure.value;
  }

  RxBool isMaleSelected = false.obs;
  RxBool isFemaleSelected = false.obs;

  void selectMale() {
    isMaleSelected.value = true;
    isFemaleSelected.value = false;
  }

  void selectFemale() {
    isMaleSelected.value = false;
    isFemaleSelected.value = true;
  }

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

  String iterateUserProvince(String province) {
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
    isLoading.value = true;
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token;

    try {
      token = await firebaseMessaging.getToken();
      print('FCM Token: $token');
    } catch (error) {
      print('Error getting FCM token: $error');
    }

    print("otottoootototototoot $token");
    // Save credentials logic here.
    DateTime get_current_date = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    // Format the current date using the DateFormat object.
    String formattedDate = dateFormat.format(get_current_date);
    // log(formattedDate.toString());

    var response = await postRequest(signUpLink, {
      "join_date": formattedDate,
      "password": user_password,
      "gender": gender,
      "number": user_phone,
      "name": user_name,
      "province": iterateUserProvince(user_province),
      "status": "online",
      "user_token": token
    });

    if (response['status'] == "faild") {
      defaultToast(
          massage: "لم يتم انشاء حساب يرجى التأكد من الحقول",
          state: ToastStates.ERROR);
    }
    if (response['status'] == "success") {
      onSuccessfulUserAuth(response, "تم انشاء حساب بنجاح");
    }

    if (response['account_exists'] == "yes") {
      defaultToast(
          massage: "! الحساب موجود مسبقا الرجاء استخدام رقمك الشخصي",
          state: ToastStates.ERROR);
    }
    isLoading.value = false;
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
      isLoading.value = true;
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
