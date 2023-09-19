import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/colors.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';
import 'package:permission_handler/permission_handler.dart';

Widget locationWidget(
        {required String title,
        required context,
        required int whichPage,
        required Size size}) =>
    Padding(
      key: const Key('first'),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: () async {
          // Check if location permission is granted
          final status = await Permission.location.request();

          if (status.isGranted) {
            // Permission granted, navigate to the desired screen
            switch (whichPage) {
              case 1:
                Get.toNamed("/map_screen", arguments: whichPage);
                break;
              case 2:
                Get.toNamed("/map_screen", arguments: whichPage);
                break;
              case 3:
                Get.toNamed("/recyclingmap");
                break;
            }
          } else if (status.isDenied) {
            defaultToast(
                massage: 'لن تستطيع التقديم بدون تحديد الموقع',
                state: ToastStates.ERROR);
          } else if (status.isPermanentlyDenied) {
            // to allow the user to manually enable the location permission
            openAppSettings();
          }
        },
        child: Container(
          key: const Key('first'),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(16.0), // Adjust the radius as needed
            color: const Color.fromARGB(255, 247, 247, 247),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8), // Shadow color
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(
                    0, 5), // Shadow position [horizontal, vertical]
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Stack(
              children: [
                const Image(
                  image: AssetImage('assets/location.png'),
                  fit: BoxFit.cover,
                ),
                Container(
                    height: size.height * 0.13,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.35),
                          spreadRadius: 6,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );

Widget locationSelectedWidget(
        {required context, required int whichPage, required Size size}) =>
    Padding(
      key: const Key('second'),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: () {
          switch (whichPage) {
            case 1:
              Get.toNamed("/map_screen", arguments: whichPage);

              break;
            case 2:
              Get.toNamed("/map_screen", arguments: whichPage);

              break;
            case 3:
              Get.toNamed("/recyclingmap");
              break;
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(16.0), // Adjust the radius as needed
            color: const Color.fromARGB(255, 247, 247, 247),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8), // Shadow color
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(
                    0, 5), // Shadow position [horizontal, vertical]
              ),
            ],
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                height: size.height * 0.13,
                width: double.infinity,
                decoration: BoxDecoration(color: mainColor),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'تم تحديد الموقع بنجاح',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Text(
                      '- إضغط للتعديل -',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
