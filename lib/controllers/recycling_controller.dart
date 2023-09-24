// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';
import 'package:madenati/db/local/shared_preference.dart';
import 'reusable_functions.dart';

class RecyclingController extends GetxController {
  RxBool isLoading = false.obs;
  RxDouble imageOpacity = 0.0.obs;
  RxDouble textOpacity = 0.0.obs;
  RxDouble buttonOpacity = 0.0.obs;
  RxBool locationSelected = false.obs;
  bool isDropdownOpen = false;
  RxInt isShowImage = 1.obs;
  List<String> recyclingItemList = [
    'زجاج',
    'بلاستيك',
    'إلكترونيات',
    'حديد',
    'أوراق',
  ];
  RxString selectedRecyclingItem = 'زجاج'.obs;
  Random randy = Random();
  TextEditingController itemWieghtController = TextEditingController();
  File? recyclingItemImage;
  var picker = ImagePicker();
  var response;

  @override
  void dispose() {
    super.dispose();
    itemWieghtController.dispose();
  }

  void loading() {
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

  clearFieldsAndGoHome(description, location) {
    removeRecyclingItemImage();
    itemWieghtController.text = "";
    selectedRecyclingItem.value = recyclingItemList[0];
    isShowImage.value = 1;
    location = "";
    locationSelected.value = false;
    Get.back();
    update();
  }

//REFACTOR : FROM SWITCH TO MAP
  int fromTextToIntRecyclingItem() {
    int recyclingItemNumber = 0;
    switch (selectedRecyclingItem.value) {
      case 'زجاج':
        recyclingItemNumber = 1;
        break;
      case 'بلاستيك':
        recyclingItemNumber = 2;
        break;
      case 'إلكترونيات':
        recyclingItemNumber = 3;
        break;
      case 'حديد':
        recyclingItemNumber = 4;
        break;
      case 'أوراق':
        recyclingItemNumber = 5;
        break;
    }
    return recyclingItemNumber == 0 ? 1 : recyclingItemNumber;
  }

  String fromIntToTextRecyclingItem(int itemNumber) {
    String recyclingItemText = '';
    switch (itemNumber) {
      case 1:
        recyclingItemText = 'زجاج';
        break;
      case 2:
        recyclingItemText = 'بلاستيك';
        break;
      case 3:
        recyclingItemText = 'إلكترونيات';
        break;
      case 4:
        recyclingItemText = 'حديد';
        break;
    }
    return recyclingItemText;
  }

  switchSelectedRecyclingItem(newValue) =>
      selectedRecyclingItem.value = newValue;

  toggleDropdown() => isDropdownOpen = !isDropdownOpen;

  pickRecyclingItemImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        recyclingItemImage = File(pickedFile.path);
        int a = randy.nextInt(300);
        isShowImage.value = a;
        update();
      }
    } catch (exe) {
      return;
    }
  }

  pickRecyclingItemImageFromCamera() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        recyclingItemImage = File(pickedFile.path);
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

  void removeRecyclingItemImage() {
    recyclingItemImage = null;
    isShowImage.value = 1;
//
    update();
  }

  uploadRecyclingItem(String location, String weight) async {
    isLoading.value = true;

    response = await postRequestWithFile(
        recyclingOrderLink,
        recyclingItemImage,
        {
          "material_type": fromTextToIntRecyclingItem()
              .toString(), // fromTextToIntRecyclingItem(),
          "material_weight":
              "${int.parse(weight)}", //int.parse(weight) , //always numbers
          "material_img": recyclingItemImage.toString(),
          "material_location": location,
          "recycler_id": CacheHelper.getData(key: "user_id"),
          "order_date": getCurrentDate().toString()
        },
        "material_img");
    if (response['status'] == 'success') {
      defaultToast(massage: "تم ارسال الطلب بنجاح", state: ToastStates.SUCCESS);
      clearFieldsAndGoHome(weight, location);
    }

    if (response['status'] == 'faild') {
      defaultToast(massage: "faild", state: ToastStates.ERROR);
    }
    if (response['status'] == 'no_user') {
      defaultToast(massage: "no  user", state: ToastStates.ERROR);
    }
    isLoading.value = false;
  }

  checkRecyclingItemsData(
    String weight,
    geographicLocation,
  ) {

    print(geographicLocation);
    if (weight.isEmpty) {
      defaultToast(
          massage: "الرجاء تحديد وزن المادة", state: ToastStates.ERROR);
      return;
    }

    if (geographicLocation == null) {
      defaultToast(massage: "الرجاء تحديد موقعك", state: ToastStates.ERROR);
      return;
    }

    if (recyclingItemImage == null) {
      defaultToast(massage: "يجب إرفاق صورة للمواد", state: ToastStates.ERROR);
      return;
    }

    uploadRecyclingItem(geographicLocation, weight);
  }
}
