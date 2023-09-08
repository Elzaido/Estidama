import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/ui/pages/main_pages/home.dart';
import 'package:madenati/ui/pages/main_pages/my_complains.dart';
import 'package:madenati/ui/pages/main_pages/profile.dart';
import 'package:madenati/utilities/binding.dart';

class LauncherController extends GetxController {
  var currentIndex = 1.obs;
  //makes it observable
  final pages = <String>['/profile', '/home', '/myComplains'];
  RxBool isBottomNavigationBarVisible = true.obs;

  void changePage(int index) {
    currentIndex.value = index;
    final currentPage = pages[index];
    Get.offNamed(currentPage, id: 1);
    log('${currentIndex.value}');

    // Check if the current page's name is not in the specified list.
    if (pages.contains(currentPage)) {
      isBottomNavigationBarVisible.value = true;
    } else {
      isBottomNavigationBarVisible.value = false;
    }
    log('$isBottomNavigationBarVisible');
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
}
