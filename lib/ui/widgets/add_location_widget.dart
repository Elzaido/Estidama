import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget locationWidget(
        {required String title,
        required context,
        required int whichPage,
        required Size size}) =>
    Padding(
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
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(16.0), // Adjust the radius as needed
                color: const Color.fromARGB(255, 247, 247, 247),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4), // Shadow color
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(
                        0, 1), // Shadow position [horizontal, vertical]
                  ),
                ],
              ),
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
      ),
    );
