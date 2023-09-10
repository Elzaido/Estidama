import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/local/shared_preference.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';

class VolunteeringController extends GetxController {
  bool isDropdownOpen = false;
  List<String> volunteringTypeList = [
    'زراعة',
    'نظافة',
    'انقاذ ورعاية الحيوانات',
  ];
  List<String> volunteringGroupList = [
    'مدرسة',
    'أهل حي',
    'جمعية خيرية',
  ];

  RxString selectedVolunteringGroup = 'مدرسة'.obs;
  RxString selectedVolunteringType = 'زراعة'.obs;

  ///
  ///
  switchSelectedVolunteringType(newValue) =>
      selectedVolunteringType.value = newValue;
  switchSelectedVolunteringGroup(newValue) =>
      selectedVolunteringGroup.value = newValue;
  fromVolunteerTypeToInteger() => selectedVolunteringType.value == 'زراعة'
      ? 1
      : selectedVolunteringType.value == 'نظافة'
          ? 2
          : 3;
  fromVolunteerGroupToInteger() => selectedVolunteringType.value == 'مدرسة'
      ? 1
      : selectedVolunteringType.value == 'أهل حي'
          ? 2
          : 3;

  sendVolunteerRequest(TextEditingController volunteer_skills) async {
  var response;
 try{
     response = await postRequest(volunteeringApplicationLink, {
      "volunteering_type":fromVolunteerTypeToInteger().toString(),
      "volunteer_group": fromVolunteerGroupToInteger().toString(),
      "volunteer_skills": volunteer_skills.text,
      "user_id" : CacheHelper.getData(key: "user_id")
    });

      defaultToast(massage: 'تم إرسال الطلب بنجاح', state: ToastStates.SUCCESS);
      volunteer_skills.text="";
Get.back();

if (response['status']=='faild') {
   print("eerrr");
}
      if (response["status" == "not_allowed"]) {
        print("eerrr");
      // defaultToast(
      //     massage: "لايمكن ارسال اكثر من طلب تطوع لنفس فئة التطوع",
      //     state: ToastStates.ERROR);
    }
    if (response['status'] == 'success') {
      defaultToast(massage: 'تم إرسال الطلب بنجاح', state: ToastStates.SUCCESS);
    }
 }catch(e){
  log(0 );
 }
  //  if (response['status' == 'faild']) {
  //     defaultToast(
  //         massage: "لايمكن ارسال اكثر من طلب تطوع لنفس فئة التطوع",
  //         state: ToastStates.ERROR);
  //   }
  return response;
  }

  checkVolunteerData(TextEditingController volunteer_skills) {
    if (volunteer_skills.text .length < 20 ||
        CacheHelper.getData(key: "user_id") == null) {
      defaultToast(
          massage: "يرجى كتابة وصف لمهاراتك لايقل عن 20 حرف",
          state: ToastStates.ERROR);
    } else {
      sendVolunteerRequest(volunteer_skills);
    }
  }
}
