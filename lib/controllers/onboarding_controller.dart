import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  void navigateAndFinish({required context, required Widget widget}) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget),
          // delete previous pages when i go to the next page:
          (Route<dynamic> route) => false);
}
