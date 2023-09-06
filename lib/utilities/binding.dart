import 'package:get/get.dart';
import 'package:madenati/controllers/map_screen_controller.dart';
import 'package:madenati/controllers/register_controller.dart';
import '../controllers/complains_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/launcher_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/mycomplains_controller.dart';
import '../controllers/onboarding_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/volunteering_controller.dart';

//HERE IN THIS CLASS WE CONNECT THE CONTROLLERS PAGES WITH THE PAGES INTERFACES
///THIS CLASS IS USAUALLY CALLED IN THE MAIN FUNCTION
//implements ...ALLOWS YOU TO CALL ALL METHODS INSIDE THE CLASS
//lazyput is recomended than   put when using intial method so it wont be calld for the whole classes
//calling bindings =>calls its own controllers and this might cause an error damaging classes and making lags

class OnBoardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => OnBoardingController()), fenix: true);
  }
}

class LauncherBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LauncherController(), fenix: true);
  }
}

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => LoginController()), fenix: true);
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => RegisterController()), fenix: true);
  }
}

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => ProfileController()), fenix: true);
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => HomeController()), fenix: true);
  }
}

class MyComplainsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => MyComplainsController()), fenix: true);
  }
}

class ComplainsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => ComplainsController()), fenix: true);
  }
}

class VolunteeringBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => VolunteeringController()), fenix: true);
  }
}

class MapScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut((() => MapScreenController()), fenix: true);
  }
}