import 'package:flutter/material.dart';

Widget title({
  required String text,
}) =>
    Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, right: 20),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Cairo',
          ),
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
      ),
    );
