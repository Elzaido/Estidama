import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/remote/sql.dart';
// import 'package:madenati/ui/widgets/access_photo.dart';
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
  RxString camer_file_path = "".obs;
  File? image;
  Random randy = Random();
  // File? my_file;
  // File? my_file;
  File? complainImage;
  var picker = ImagePicker();

  //this file is for open camera
  ////
  ///
  switchSelectedComplain(newValue) => selectedComplain.value = newValue;
  switchSelectedComplainStatus(newValue) =>
      selectedComplainStatus.value = newValue;
  toggleDropdown() => isDropdownOpen = !isDropdownOpen;
  // bool checkFullFields(location, image, String description) =>
  //     location != "" && image != null && description.length > 20 ? true : false;

  pickComplainImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      complainImage = File(pickedFile.path);
      int a = randy.nextInt(300);
      isShowImage.value = a;

      update();
      // print(complainImage);
    } else {
      // log('No image selected');
    }
  }

  pickComplainImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      complainImage = File(pickedFile.path);
      int a = randy.nextInt(300);
      isShowImage.value = a;

      update();
    } else {
      // log('No image selected');
    }
  }

  void removePostImage() {
    complainImage = null;
    isShowImage.value = 1;

    update();
  }

  uploadComplain(String location, File image) async {
    var response = await postRequestWithFile(addComplainsLink, image, {
      "complainer_id": 1,
      "complain_type": 1,
      "complain_date": "ss",
      "complain_location": location,
      "complain_status": "dangerous",
      "complain_description": 'heloo',
    });

    if (response['status'] == "faild") print("fuuuck");
    return response;
  }

  sendComplain(String description, geographic_location) {
    if (description.length < 20) {
      defaultToast(
          massage: "يجب كتابة وصف للبلاغ لايقل عن 20 حرف",
          state: ToastStates.ERROR);
    }

    if (geographic_location == null) {
      defaultToast(massage: "يجب اختيار موقع البلاغ", state: ToastStates.ERROR);
    }

    if (complainImage == null) {
      defaultToast(
          massage: " يجب اختيار صورة لمكان البلاغ", state: ToastStates.ERROR);
    }
    print(complainImage!.path);
    uploadComplain(geographic_location, complainImage!);
  }
}
