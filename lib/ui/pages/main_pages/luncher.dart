// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
            )),
        bottomNavigationBar: CurvedNavigationBar(
            height: 65,
            index: 1,
            color: mainColor,
            animationDuration: Duration(milliseconds: 600),
            backgroundColor: Colors.transparent,
            onTap: controller.changePage,
            items: [
              Icon(Icons.person, color: Colors.white),
              Icon(Icons.home, color: Colors.white),
              Icon(Icons.warning, color: Colors.white)
            ]));
  }

  // floatingActionButton: Obx(() {
  //   return FloatingActionButton(
  //     backgroundColor:
  //         controller.currentIndex == 1.obs ? mainColor : Colors.white,
  //     onPressed: () {
  //       controller.currentIndex = 1.obs;
  //       controller.changePage(1);
  //     },
  //     child: Icon(Icons.home_filled,
  //         color: controller.currentIndex == 1.obs
  //             ? Colors.white
  //             : mainColor),
  //   );
  // }),
  // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  // bottomNavigationBar: Obx(() {
  //   return BottomAppBar(
  //     shape: CircularNotchedRectangle(),
  //     notchMargin: 10,
  //     child: SizedBox(
  //       height: 60,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           Row(children: [
  //             SizedBox(
  //               width: 40,
  //             ),
  //             MaterialButton(
  //               minWidth: 40,
  //               onPressed: () {
  //                 controller.currentIndex = 0.obs;
  //                 controller.changePage(0);
  //               },
  //               child: Obx(
  //                 () {
  //                   return Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Icon(
  //                         Icons.person,
  //                         color: controller.currentIndex == 0.obs
  //                             ? mainColor
  //                             : Colors.grey,
  //                       ),
  //                       Text(
  //                         'الملف الشخصي',
  //                         style: TextStyle(
  //                           fontFamily: 'Cairo',
  //                           color: controller.currentIndex == 0.obs
  //                               ? mainColor
  //                               : Colors.grey,
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               ),
  //             )
  //           ]),
  //           Row(
  //             children: [
  //               MaterialButton(
  //                 minWidth: 40,
  //                 onPressed: () {
  //                   controller.currentIndex = 2.obs;
  //                   controller.changePage(2);
  //                 },
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(
  //                       Icons.warning_rounded,
  //                       color: controller.currentIndex == 2.obs
  //                           ? mainColor
  //                           : Colors.grey,
  //                     ),
  //                     Text(
  //                       'بلاغاتي',
  //                       style: TextStyle(
  //                         fontFamily: 'Cairo',
  //                         color: controller.currentIndex == 2.obs
  //                             ? mainColor
  //                             : Colors.grey,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 40,
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
}
