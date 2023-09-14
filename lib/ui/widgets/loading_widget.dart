import 'package:flutter/material.dart';

Widget loading() => Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        child: const Padding(
          padding: EdgeInsets.all(18.0),
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 102, 187, 106),
          ),
        ),
      ),
    );
