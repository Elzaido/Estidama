import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'separator_widget.dart';

Widget myComplainItem(context, ComplainsModel complainModel,
    MyComplainsController myComplainsController, index) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(16.0), // Adjust the radius as needed
            color: const Color.fromARGB(255, 247, 247, 247),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4), // Shadow color
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(
                    0, 2), // Shadow position [horizontal, vertical]
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          complainModel.complainDescription.toString(),
                          maxLines: 2,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          complainModel.complainDate.toString(),
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 15, fontFamily: 'Cairo'),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: complainModel.complainImagePath == ""
                      ? Image(
                          image: NetworkImage(
                            "$complainImages/${complainModel.complainImagePath.toString()}",
                          ),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.photo,
                          size: 50,
                          color: Colors.green,
                        ),
                ),
              ]),
              separator(),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      log(complainModel.complainId.toString());
                      myComplainsController.deleteComplain(
                          complainModel.complainId.toString(), index);
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        Text(
                          'حذف',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ],
          )));
}
