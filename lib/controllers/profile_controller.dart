import 'dart:math';

import 'package:get/get.dart';
import 'package:madenati/db/local/shared_preference.dart';

class ProfileController extends GetxController {
  Map<int, String> provincesx = {
    1: "اربد",
    2: "الزرقاء",
    3: "عمان",
    4: "مأدبا",
    5: "جرش",
    6: "عجلون",
    7: 'معان',
    8: "المفرق",
    9: "العقبة",
    10: "البلقاء",
    11: "الكرك",
    12: "الطفيلة"
  };
  String iterateUserProvince(int provinceNum) {
    //THIS FUNCTION IS USED TO LOOP ON THE PROVINCES
    // AND GET KEYS TO SAVE WITH THE CREDENTIALS
    String value = '';
    try {
      provincesx.forEach((k, v) {
        if (k == provinceNum) {
          value = v;
          return;
        }
      });
    } catch (e) {
      log(e.hashCode);
    }
    return value.toString();
  }

  signOutActions() async {
    try {
      CacheHelper.clearData();
      await Get.offAllNamed("/login");
    } catch (e) {
      log(e.hashCode);
    }
  }
}
