import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ComplainsController extends GetxController {
  RxString selectedComplain = 'دخان المصانع'.obs;
  bool isDropdownOpen = false;
  List<String> complainsList = [
    'دخان المصانع',
    'نقص في حاويات القمامة',
    'كلاب ضالة',
    'قطع أشجار الغابات',
  ];
  RxString selectedStatus = 'قليلة الخطورة'.obs;
  List<String> complainStatus = [
    'قليلة الخطورة',
    'متوسطة الخطورة',
    'عالية الخطورة'
  ];

  changeCompalin(newValue) => selectedComplain.value = newValue;
  changeStatus(newValue) => selectedStatus.value = newValue;

  File? complainImage;
  var picker = ImagePicker();

  Future<void> pickComplainImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      complainImage = File(pickedFile.path);
    } else {
      log('No image selected');
    }
  }

  Future<void> pickComplainImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      complainImage = File(pickedFile.path);
    } else {
      log('No image selected');
    }
  }

  void removePostImage() {
    complainImage = null;
  }
}
