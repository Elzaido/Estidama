import 'package:get/get.dart';

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
  String iterateUserProvince(int province_num) {
    //THIS FUNCTION IS USED TO LOOP ON THE PROVINCES
    // AND GET KEYS TO SAVE WITH THE CREDENTIALS

    String value = '';

    provincesx.forEach((k, v) {
      if (v == province_num) {
        value = v;
        return;
      }
    });
    return value.toString();
  }
 
}
