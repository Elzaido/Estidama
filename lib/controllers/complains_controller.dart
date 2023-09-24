// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/local/shared_preference.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';
import 'reusable_functions.dart';

class ComplainsController extends GetxController {
  RxBool isLoading = false.obs;
  bool isDropdownOpen = false;
  RxInt isShowImage = 1.obs;
  RxBool locationSelected = false.obs;

  List<String> complainsList = [
    'صرف صحي',
    'ضوضاء و ضجيج',
    'تراكم نفايات',
    'نقص في حاويات القمامة',
    'تلوث هواء',
    'معامل طوب / حجر'
  ];
  RxString selectedComplain = 'صرف صحي'.obs;
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

  clearFieldsAndGoHome(location) {
    descriptionController.text = "";
    complainImage = null;
    selectedComplain.value = complainsList[0];
    selectedComplainStatus.value = complainStatus[0];
    isShowImage.value = 1;
    location = "";
    locationSelected.value = false;
    update();
  }

  int fromTextToIntComplain() {
    int complainNumber = 0;
    switch (selectedComplain.value) {
      case 'صرف صحي':
        complainNumber = 1;
        break;
      case 'ضوضاء و ضجيج':
        complainNumber = 2;
        break;
      case 'تراكم نفايات':
        complainNumber = 3;
        break;
      case 'نقص في حاويات القمامة':
        complainNumber = 4;
        break;
      case 'تلوث هواء':
        complainNumber = 4;
        break;
      case 'معامل طوب / حجر':
        complainNumber = 4;
        break;
      case 'حيوانات ضالة ورعي جائر':
        complainNumber = 4;
        break;
    }
    return complainNumber;
  }

  switchSelectedComplain(newValue) => selectedComplain.value = newValue;
  switchSelectedComplainStatus(newValue) =>
      selectedComplainStatus.value = newValue;

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

  uploadComplain(String location) async {
    try {
      response = await postRequestWithFile(
          addComplainsLink,
          complainImage,
          {
            "complainer_id":
                CacheHelper.getData(key: "user_id"), //get it from Uid
            "complain_type":
                fromTextToIntComplain().toString(), //always numbers
            "complain_date": getCurrentDate().toString(),
            "complain_location": location,
            "complain_status": selectedComplainStatus.value.toString(),
            "complain_description": descriptionController.text.toString(),
          },
          "complain_image_path");
      if (response['status'] == 'success') {
        defaultToast(
            massage: "تم ارسال الشكوى بنجاح", state: ToastStates.SUCCESS);
        clearFieldsAndGoHome(location);
        isLoading.value = false;
      }

      if (response['status'] == 'faild') {
        defaultToast(massage: "faild", state: ToastStates.ERROR);
        isLoading.value = false;
      }
    } catch (exe) {
      defaultToast(
          massage: "حدث خطب ما يرجى الاعادة لاحقا", state: ToastStates.ERROR);
      isLoading.value = false;
    }
    return response;
  }

  void checkComplainsData(
    geographicLocation,
  ) {
    isLoading.value = true;
    if (descriptionController.text.length < 20) {
      defaultToast(
          massage: "يجب كتابة وصف للشكوى لايقل عن 20 حرف",
          state: ToastStates.ERROR);
      isLoading.value = false;
      return;
    }

    if (geographicLocation == null) {
      defaultToast(massage: "يجب اختيار موقع للشكوى", state: ToastStates.ERROR);
      isLoading.value = false;
      return;
    }

    if (complainImage == null) {
      defaultToast(
          massage: " يجب اختيار صورة لمكان الشكوى", state: ToastStates.ERROR);
      isLoading.value = false;
      return;
    }

    uploadComplain(geographicLocation);
  }
}
