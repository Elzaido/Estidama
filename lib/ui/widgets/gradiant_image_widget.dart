import 'package:flutter/material.dart';

Widget gradientImage({
  required String image,
}) =>
    Stack(alignment: Alignment.bottomCenter, children: [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.5), Colors.transparent],
          ),
        ),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
      Container(
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.9),
                spreadRadius: 10,
                blurRadius: 30,
                offset: const Offset(
                    1, 40), // This controls the elevation from the top
              ),
            ],
          ),
          child: const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ) // Y

          ),
    ]);
