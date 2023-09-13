import 'package:flutter/material.dart';

import '../../constants/colors.dart';

Widget carsoulItem({
  required String image,
  required String title,
  required String text,
}) =>
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
                width: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withOpacity(0.9),
                      spreadRadius: 6,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 35,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.ltr,
                        ),
                        Text(
                          text,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.ltr,
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
