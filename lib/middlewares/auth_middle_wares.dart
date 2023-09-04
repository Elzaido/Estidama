import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../db/local/shared_preference.dart';

//IN THIS CLASS WE CHECK WHETHER THE USER IS SIGNED IN OR NOT
class AuthMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (CacheHelper.getData(key: 'onBoarding') == "true") {
      Get.offAllNamed("/launcher");
      return const RouteSettings(name: "/launcher");
    } else {
      Get.offAllNamed("/on_boarding");
    }
    return null;
  }
}
