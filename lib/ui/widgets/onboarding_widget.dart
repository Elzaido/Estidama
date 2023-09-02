import 'package:flutter/material.dart';
import '../../models/boardingmodel.dart';

Widget boardingItemBuilder(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(image: AssetImage('${model.image}')),
        const SizedBox(
          height: 25,
        ),
        Text(
          '${model.title}',
          style: const TextStyle(
            fontSize: 30,
            fontFamily: 'Cairo',
            // fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
