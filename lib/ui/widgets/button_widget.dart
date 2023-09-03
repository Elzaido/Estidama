import 'package:flutter/material.dart';
import '../../constants/colors.dart';

Widget button({required void Function()? onPressed, required Widget? child}) =>
    SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onPressed,
        child: child,
      ),
    );
