import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget addLocation(
        {required String image,
        required String title,
        required context,
        required int whichPage}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: () {
          //updated from navigator to getnamed
          Get.toNamed("/map_screen", arguments: whichPage);
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
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(16.0), // Adjust the radius as needed
                color: const Color.fromARGB(255, 247, 247, 247),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4), // Shadow color
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(
                        0, 2), // Shadow position [horizontal, vertical]
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Image(
                    image: AssetImage(image),
                    fit: BoxFit.fill,
                  ),
                  Container(
                      height: 110,
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
