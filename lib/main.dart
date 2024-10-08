// ignore_for_file: camel_case_types, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/ui/pages/authentication/verification.dart';
import 'controllers/complains_controller.dart';
import 'controllers/recycling_controller.dart';
import 'controllers/volunteering_controller.dart';
import 'utilities/firebase_options.dart';
import 'package:madenati/ui/pages/authentication/register.dart';
import 'package:madenati/ui/pages/main_pages/about_app.dart';
import 'package:madenati/ui/pages/main_pages/activities.dart';
import 'package:madenati/ui/pages/main_pages/googlemaps.dart';
import 'package:madenati/ui/pages/main_pages/home.dart';
import 'package:madenati/ui/pages/main_pages/luncher.dart';
import 'package:madenati/ui/pages/main_pages/recycling_form.dart';
import 'package:madenati/ui/pages/main_pages/recycling_map.dart';
import 'package:madenati/ui/pages/main_pages/volunteering.dart';
import 'package:madenati/ui/pages/on_boarding.dart';
import 'package:madenati/utilities/firebase_messeging.dart';
import 'db/local/shared_preference.dart';
import 'ui/pages/authentication/login.dart';
import 'ui/pages/main_pages/complains.dart';
import 'ui/pages/main_pages/profile.dart';
import 'ui/pages/main_pages/recycling.dart';
import 'utilities/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Get.put(ComplainsController());
  Get.put(RecyclingController());
  Get.put(VolunteeringController());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initFirebaseMessaging();
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    final heroController =
        HeroController(); // Create an instance of HeroController

    //onBoarding =true means it finished the page
    return HeroControllerScope(
        controller: heroController,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: CacheHelper.getData(key: 'onBoarding') == true
              ? (CacheHelper.getData(key: "isLogin") == true
                  ? "/launcher"
                  : "/login")
              : "/on_boarding",
          getPages: [
            GetPage(
                name: '/on_boarding',
                page: () => OnBoarding(),
                binding: OnBoardingBinding()),
            GetPage(
                name: "/login",
                page: (() => const LoginPage()),
                binding: LoginBinding()),
            GetPage(
                name: "/register",
                page: (() => const Register()),
                binding: RegisterBinding()),
            GetPage(
                name: '/verification',
                page: (() => const Verification()),
                binding: VerifyBinding()),
            GetPage(
                name: '/launcher',
                page: (() => Luncher()),
                binding: LauncherBindings()),
            GetPage(
              name: '/home',
              page: (() => const Home()),
              binding: HomeBinding(),
            ),
            GetPage(
              name: '/profile',
              page: (() => Profile()),
              binding: ProfileBinding(),
            ),
            GetPage(
                name: '/myComplains',
                page: (() => Activities()),
                binding: MyComplainsBinding()),
            GetPage(
                name: '/complains',
                page: (() => Complains()),
                binding: ComplainsBinding()),
            GetPage(
                name: '/volunteering',
                page: (() => const Volunteering()),
                binding: VolunteeringBinding()),
            GetPage(
                name: '/map_screen',
                page: (() => const MapScreen()),
                binding: MapScreenBinding()),
            GetPage(
                name: '/recycling',
                page: (() => const Recycling()),
                binding: RecyclingBinding()),
            GetPage(
                name: '/recyclingform',
                page: (() => RecyclingForm()),
                binding: RecyclingBinding()),
            GetPage(
                name: '/recyclingmap',
                page: (() => const RecyclingLocationsMap()),
                binding: RecyclingBinding()),
            GetPage(
                name: '/aboutapp',
                page: (() => const AboutApp()),
                binding: AboutAppBinding()),
          ],
        ));
  }
}
