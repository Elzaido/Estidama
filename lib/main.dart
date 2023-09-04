// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/ui/pages/authentication/register.dart';
import 'package:madenati/ui/pages/main_pages/home.dart';
import 'package:madenati/ui/pages/main_pages/luncher.dart';
import 'package:madenati/ui/pages/main_pages/my_complains.dart';
import 'package:madenati/ui/pages/main_pages/volunteering.dart';
import 'package:madenati/ui/pages/on_boarding.dart';
import 'constants/ids.dart';
import 'controllers/complains_controller.dart';
import 'db/local/shared_preference.dart';
import 'ui/pages/authentication/login.dart';
import 'ui/pages/main_pages/complains.dart';
import 'ui/pages/main_pages/profile.dart';
import 'utilities/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  Get.put(ComplainsController());
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    //onBoarding =true means it finished the page
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: CacheHelper.getData(key: 'onBoarding') == true
          ? CacheHelper.getData(key: "isLogin") == true
              ? "/launcher"
              : "/login"
          : "/on_boarding",
      getPages: [
        GetPage(
            name: '/on_boarding',
            page: () => const OnBoarding(),
            binding: OnBoardingBinding()),
        GetPage(
            name: "/login",
            page: (() => const LoginPage()),
            binding: LoginBinding()),
        GetPage(
            name: "/register",
            page:( () => const Register()),
            binding: RegisterBinding()),
        GetPage(
            name: '/launcher',
            page: (() => const Luncher()),
            binding: LauncherBindings()),
        GetPage(
          name: '/home',
          page: (() => const Home()),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/profile',
          page: (() => const Profile()),
          binding: ProfileBinding(),
        ),
        GetPage(
            name: '/myComplains',
            page: (() => const MyComplains()),
            binding: MyComplainsBinding()),
        GetPage(
            name: '/complains',
            page: (() => Complains()),
            binding: ComplainsBinding()),
        GetPage(
            name: '/volunteering',
            page: (() => const Volunteering()),
            binding: VolunteeringBinding()),
      ],
    );
  }
}
