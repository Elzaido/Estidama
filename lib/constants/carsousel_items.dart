import 'package:flutter/material.dart';
import 'package:madenati/constants/colors.dart';

// If you want to add a carsoul item add it here and it will appear in the UI.

List<Widget> images = [
  carsoulItem(
      image: 'assets/volunteering.png',
      title: 'تطوع',
      text:
          'قام أحد فرق التطوع في مدينة إربد بزراعة 20 شجرة على طريق الواصل بين منطقة أيدون و الحصن'),
];

Widget carsoulItem({
  required String image,
  required String title,
  required String text,
}) =>
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
          ),
          Container(
              height: 1000,
              width: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: mainColor.withOpacity(0.7),
                    spreadRadius: 6,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.topRight,
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
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Cairo',
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );