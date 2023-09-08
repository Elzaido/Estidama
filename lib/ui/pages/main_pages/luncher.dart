import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../controllers/launcher_controller.dart';

class Luncher extends StatelessWidget {
  const Luncher({super.key});

  @override
  Widget build(BuildContext context) {
    LauncherController controller = Get.find();
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Navigator(
          key: Get.nestedKey(1),
          initialRoute: "/home",
          onGenerateRoute: controller.onGenerateRoute,
        ),
      ),
      bottomNavigationBar: Obx(() {
        return controller.isBottomNavigationBarVisible.value
            ? CurvedNavigationBar(
                height: 65,
                index: 1,
                color: mainColor,
                animationDuration: const Duration(milliseconds: 600),
                backgroundColor: Colors.transparent,
                onTap: controller.changePage,
                items: const [
                  Icon(Icons.person, color: Colors.white),
                  Icon(Icons.home, color: Colors.white),
                  Icon(Icons.warning, color: Colors.white)
                ],
              )
            : Container(
                height: 1,
              );
      }),
    );
  }
}
