import 'package:flutter/material.dart';

Widget genderButton(
        {required String title, required void Function()? onPressed}) =>
    Expanded(
        child: ElevatedButton(
            onPressed: onPressed,
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Cairo'))));
