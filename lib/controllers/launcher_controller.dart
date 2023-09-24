import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/ui/pages/main_pages/activities.dart';
import 'package:madenati/ui/pages/main_pages/home.dart';
import 'package:madenati/ui/pages/main_pages/profile.dart';
import 'package:madenati/utilities/binding.dart';

class LauncherController extends GetxController {
  var currentIndex = 1.obs;
  //makes it observable
  final pages = <String>['/profile', '/home', '/myComplains'];

  void changePage(int index) {
    try {
      currentIndex.value = index;
      final currentPage = pages[index];
      Get.offNamed(currentPage, id: 1);
    } catch (e) {
      log(e.hashCode);
    }
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/profile') {
      return GetPageRoute(
        settings: settings,
        page: () => Profile(),
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
        page: () => Activities(),
        binding: MyComplainsBinding(),
      );
    }

    return null;
  }
}
