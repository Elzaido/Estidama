// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/local/shared_preference.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';

class ComplainsController extends GetxController {
  bool isDropdownOpen = false;
  RxInt isShowImage = 1.obs;
  List<String> complainsList = [
    'دخان المصانع',
    'نقص في حاويات القمامة',
    'كلاب ضالة',
    'قطع أشجار الغابات',
  ];

  RxString selectedComplain = 'دخان المصانع'.obs;
  List<String> complainStatus = [
    'قليلة الخطورة',
    'متوسطة الخطورة',
    'عالية الخطورة'
  ];
  RxString selectedComplainStatus = 'قليلة الخطورة'.obs;
  Random randy = Random();
  TextEditingController descriptionController = TextEditingController();

  File? complainImage;
  var picker = ImagePicker();
  var response;
  // whichCo

  clearFieldsAndGoHome(description, location) {
    descriptionController.text = "";
    complainImage = null;
    selectedComplain.value = complainsList[0];
    selectedComplainStatus.value = complainStatus[0];
    isShowImage.value = 1;
    location = "";
    // Get.offNamed("/launcher");
    update();
  }

  int fromTextToIntComplain() {
    int complainNumber = 0;
    switch (selectedComplain.value) {
      case 'دخان المصانع':
        complainNumber = 1;
        break;
      case 'نقص في حاويات القمامة':
        complainNumber = 2;
        break;
      case 'كلاب ضالة':
        complainNumber = 3;
        break;
      case 'قطع أشجار الغابات':
        complainNumber = 4;
        break;
    }
    return complainNumber;
  }

  switchSelectedComplain(newValue) => selectedComplain.value = newValue;
  switchSelectedComplainStatus(newValue) =>
      selectedComplainStatus.value = newValue;
  toggleDropdown() => isDropdownOpen = !isDropdownOpen;

  pickComplainImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        complainImage = File(pickedFile.path);
        int a = randy.nextInt(300);
        isShowImage.value = a;

        update();
      }
    } catch (exe) {
      return;
    }
  }

  pickComplainImageFromCamera() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        complainImage = File(pickedFile.path);
        int a = randy.nextInt(300);
        isShowImage.value = a;

        update();
      } else {
        print('No image selected');
      }
    } catch (ex) {
      return;
    }
  }

  void removePostImage() {
    complainImage = null;
    isShowImage.value = 1;
//
    update();
  }

  uploadComplain(String location, String description) async {
    DateTime _currentDate = DateTime.now();
    DateFormat _dateFormatter = DateFormat.yMd();
    String getDateAsString = _dateFormatter.format(_currentDate);

    try {
      response = await postRequestWithFile(addComplainsLink, complainImage, {
        "complainer_id": CacheHelper.getData(key: "user_id"), //get it from Uid
        "complain_type": fromTextToIntComplain().toString(), //always numbers
        "complain_date": getDateAsString,
        "complain_location": location,
        "complain_status": selectedComplainStatus.value.toString(),
        "complain_description": description.toString(),
      });
      if (response['status'] == 'success') {
        defaultToast(
            massage: "تم ارسال البلاغ بنجاح", state: ToastStates.SUCCESS);
        clearFieldsAndGoHome(description, location);
      }

      if (response['status'] == 'faild') {
        defaultToast(massage: "faild", state: ToastStates.SUCCESS);
      }
    } catch (exe) {
      defaultToast(
          massage: "حدث خطب ما يرجى الاعادة لاحقا", state: ToastStates.SUCCESS);
    }

    return response;
  }

  void checkComplainsData(
    String description,
    geographic_location,
  ) {
    if (description.length < 20) {
      defaultToast(
          massage: "يجب كتابة وصف للبلاغ لايقل عن 20 حرف",
          state: ToastStates.ERROR);
      return;
    }

    if (geographic_location == null) {
      defaultToast(massage: "يجب اختيار موقع البلاغ", state: ToastStates.ERROR);
      return;
    }

    if (complainImage == null) {
      defaultToast(
          massage: " يجب اختيار صورة لمكان البلاغ", state: ToastStates.ERROR);
      return;
    }

    uploadComplain(geographic_location, description);

    //COMPLAINS DATA:
    // 1 IMAGE FILE, LOCATION STRING , COMPLAIN STRING,
    //STATUS STRING, UID STRING , DATE STRING
  }
}
