import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/ui/pages/main_pages/home.dart';
import 'package:madenati/ui/pages/main_pages/my_complains.dart';
import 'package:madenati/ui/pages/main_pages/profile.dart';
import 'package:madenati/utilities/binding.dart';

import '../constants/colors.dart';

class LauncherController extends GetxController {
  static LauncherController get to => Get.find();
  var currentIndex = 1.obs;
  //makes it observable
  final pages = <String>['/profile', '/home', '/myComplains'];

  void changePage(int index) {
    currentIndex.value = index;
    Get.offNamed(pages[index], id: 1);
    log('${currentIndex.value}');
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/profile') {
      return GetPageRoute(
        settings: settings,
        page: () => const Profile(),
        binding: ProfileBinding(),
      );
    } else if (settings.name == '/home') {
      return GetPageRoute(
        settings: settings,
        page: () => const Home(),
        binding: HomeBinding(),
      );
    } else if (settings.name == '/myComplains') {
      return GetPageRoute(
        settings: settings,
        page: () => const MyComplains(),
        binding: MyComplainsBinding(),
      );
    }

    return null;
  }

  Color getButtonColor(int buttonIndex) {
    return currentIndex.value == buttonIndex ? mainColor : Colors.grey;
  }
}
