import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';

class RecyclingController extends GetxController {
  bool isDropdownOpen = false;
  RxInt isShowImage = 1.obs;
  List<String> recyclingItemList = [
    'زجاج',
    'بلاستيك',
    'إلكترونيات',
    'حديد',
  ];

  RxString selectedRecyclingItem = 'زجاج'.obs;

  Random randy = Random();
  TextEditingController descriptionController = TextEditingController();

  File? recyclingItemImage;
  var picker = ImagePicker();
  var response;
  // whichCo

  clearFieldsAndGoHome(description, location) {
    descriptionController.text = "";
    recyclingItemImage = null;
    selectedRecyclingItem.value = recyclingItemList[0];
    isShowImage.value = 1;
    location = "";
    update();
  }

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
    }
    return recyclingItemNumber;
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
    try {
      response =
          await postRequestWithFile(addComplainsLink, recyclingItemImage, {
        "item_id": "5", //get it from Uid
        "item_type": fromTextToIntRecyclingItem().toString(), //always numbers
        "item_location": location,
        "item_weight": weight,
      });
      if (response['status'] == 'success') {
        defaultToast(
            massage: "تم ارسال البلاغ بنجاح", state: ToastStates.SUCCESS);
        clearFieldsAndGoHome(weight, location);
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

  void checkRecyclingItemsData(
    String weight,
    geographic_location,
  ) {
    if (weight.isEmpty) {
      defaultToast(
          massage: "الرجاء تحديد وزن المادة", state: ToastStates.ERROR);
      return;
    }

    if (geographic_location == null) {
      defaultToast(massage: "الرجاء تحديد موقعك", state: ToastStates.ERROR);
      return;
    }

    if (recyclingItemImage == null) {
      defaultToast(massage: "يجب إرفاق صورة للمواد", state: ToastStates.ERROR);
      return;
    }

    uploadRecyclingItem(geographic_location, weight);
  }
}
