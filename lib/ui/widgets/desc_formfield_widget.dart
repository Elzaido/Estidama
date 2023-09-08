import 'package:flutter/material.dart';

Widget descFormField(
        {required String hint,
        required TextEditingController textController}) =>
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: textController,
        textDirection: TextDirection.rtl,
        maxLines: 5, autofocus: false,
        // Set the number of lines you want to display
        decoration: InputDecoration(
            hintText: hint,
            hintTextDirection: TextDirection.rtl,
            hintStyle: const TextStyle(
              fontFamily: 'Cairo',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
            // Add border styling
            ),
      ),
    );
