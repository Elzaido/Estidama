import 'package:flutter/material.dart';
import '../../models/boardingmodel.dart';

Widget boardingItemBuilder(BoardingModel model) => Stack(
      children: [
        SizedBox(
            height: 2000,
            child: Image(
              image: AssetImage('${model.image}'),
              fit: BoxFit.cover,
            )),
        const SizedBox(
          height: 25,
        ),
        Container(
            height: 2000,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  spreadRadius: 6,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
                child: Text(
                  '${model.title}',
                  style: const TextStyle(
                    fontSize: 35,
                    fontFamily: 'Cairo',
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )),
        const SizedBox(
          height: 20,
        ),
      ],
    );
