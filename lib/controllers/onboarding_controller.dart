import 'dart:math';

import 'package:get/get.dart';
import 'package:madenati/db/local/shared_preference.dart';

class OnBoardingController extends GetxController {
  RxBool isLast = false.obs;
  void submit() {
    try {
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
        if (value) {
          Get.offNamed("/login");
        }
      });
    } catch (e) {
      log(e.hashCode);
    }
  }
}
