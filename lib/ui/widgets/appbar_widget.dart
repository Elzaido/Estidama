import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/launcher_controller.dart';
import '../../constants/colors.dart';

LauncherController controller = Get.find();

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  required String title,
  bool isHome = false,
}) {
  return AppBar(
    backgroundColor: mainColor,
    title: isHome
        ? Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold),
            ),
          )
        : Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold),
          ),
    leading: !isHome
        ? IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              controller.isBottomNavigationBarVisible.value = true;
            },
          )
        : null,
  );
}
