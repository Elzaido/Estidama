// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/local/shared_preference.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';
import '../ui/widgets/interface_components.dart';
class VolunteeringController extends GetxController {
  bool isDropdownOpen = false;
  List<String> volunteringTypeList = [
    'نظافة',
    'رعاية الحيوانات',
  ];
  List<String> volunteringGroupList = [
    'مدرسة',
    'أهل حي',
    'جمعية خيرية',
  ];

  RxString selectedVolunteringGroup = 'مدرسة'.obs;
  RxString selectedVolunteringType = 'نظافة'.obs;

  RxDouble imageOpacity = 0.0.obs;
  RxDouble textOpacity = 0.0.obs;
  RxDouble buttonOpacity = 0.0.obs;

  RxInt volunteenerNumber = 0.obs;

  RxList<String> volunteersNameList = [""].obs;
  String volunteersSeparateName = "";

  ///
  ///

  void loading() {
    //NO SET STATE IN THE APP !  USE GETX
    // Animate opacity for the image after a short delay.
    Future.delayed(const Duration(milliseconds: 700), () {
      imageOpacity.value =
          1.0; // Set opacity to fully opaque (1.0) for fade-in.
    });
    // Animate opacity for the text after a slightly longer delay.
    Future.delayed(const Duration(milliseconds: 1100), () {
      textOpacity.value = 1.0; // Set opacity to fully opaque (1.0) for fade-in.
    });
    // Animate opacity for the button after a longer delay.
    Future.delayed(const Duration(milliseconds: 1500), () {
      buttonOpacity.value =
          1.0; // Set opacity to fully opaque (1.0) for fade-in.
    });
  }

  switchSelectedVolunteringType(newValue) =>
      selectedVolunteringType.value = newValue;
  switchSelectedVolunteringGroup(newValue) =>
      selectedVolunteringGroup.value = newValue;
  fromVolunteerTypeToInteger() => selectedVolunteringType.value == 'نظافة'
      ? 1
      : selectedVolunteringType.value == 'رعاية الحيوانات'
          ? 2
          : 1;
  fromVolunteerGroupToInteger() => selectedVolunteringGroup.value == 'مدرسة'
      ? 1
      : selectedVolunteringType.value == 'أهل حي'
          ? 2
          : 3;

  sendVolunteerRequest(TextEditingController volunteerSkills) async {
    var response;

    print(volunteersSeparateName.toString());
loading();
// Loading();
    // loading();
    try {
      response = await postRequest(volunteeringApplicationLink, {
        "volunteering_type": fromVolunteerTypeToInteger().toString(),
        "volunteer_group": fromVolunteerGroupToInteger().toString(),
        "volunteers_names": volunteersSeparateName.toString(),
        "leader_id": CacheHelper.getData(key: "user_id")
      });
      if (response["status"] == "not_allowed") {
        defaultToast(
            massage: 'لا يسمح ارسال اكثر من طلب لنفس نوع التطوع',
            state: ToastStates.SUCCESS);

        print("not_allowed");
      }
      if (response['status'] == 'success') {
        volunteersSeparateName = "";
        Get.back();

        volunteersSeparateName = "";
        defaultToast(
            massage: 'تم إرسال الطلب بنجاح', state: ToastStates.SUCCESS);
      }

      if (response['status'] == 'faild') {
        print("faild");
      }
    } catch (e) {
      log(0);
    }
    return response;
  }

  checkVolunteerData(TextEditingController volunteersNumber) {
    if (volunteersNumber.text.length <= 0 ||
        CacheHelper.getData(key: "user_id") == null) {
      defaultToast(
          massage: "يرجى  اضافة عدد المتطوعين    ", state: ToastStates.ERROR);
    } else if (volunteersSeparateName.isEmpty) {
      defaultToast(
          massage: "يرجى  كتابة اسماء المتطوعين    ", state: ToastStates.ERROR);
      return;
    } else {
      sendVolunteerRequest(volunteersNumber);
    }
  }
}
