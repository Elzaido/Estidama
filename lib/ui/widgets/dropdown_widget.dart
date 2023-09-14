import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/complains_controller.dart';
import 'package:madenati/controllers/recycling_controller.dart';
import 'package:madenati/controllers/register_controller.dart';
import 'package:madenati/controllers/volunteering_controller.dart';

Widget dropDown(
        {required String selected,
        required List<String> list,
        required int flag}) =>
    Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 15),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton(
              padding: const EdgeInsets.all(5),
              dropdownColor: const Color.fromARGB(255, 247, 247, 247),
              icon: const Icon(Icons.arrow_drop_down),
              isExpanded: true,
              iconSize: 22,
              style: const TextStyle(color: Colors.black, fontSize: 15),
              value: selected,
              underline: const SizedBox(),
              items: list.map((valueItem) {
                return DropdownMenuItem(
                    value: valueItem,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          valueItem,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ));
              }).toList(),
              onChanged: (newValue) {
                try {
                  switch (flag) {
                    case 1:
                      RegisterController registerController = Get.find();

                      registerController.changeProvince(newValue);
                      break;

                    case 2:
                      ComplainsController complainsController = Get.find();

                      complainsController.switchSelectedComplain(newValue);
                      break;

                    case 3:
                      ComplainsController complainsController = Get.find();

                      complainsController
                          .switchSelectedComplainStatus(newValue);
                      break;
                    case 4:
                      RecyclingController recyclingController = Get.find();

                      recyclingController.switchSelectedRecyclingItem(newValue);
                      break;
                    case 5:
                      VolunteeringController volunteeringController =
                          Get.find();

                      volunteeringController
                          .switchSelectedVolunteringType(newValue);
                      break;
                    case 6:
                      VolunteeringController volunteeringController =
                          Get.find();

                      volunteeringController
                          .switchSelectedVolunteringGroup(newValue);
                      break;
                  }
                } catch (exception) {
                  log('$exception');
                }

                selected = newValue!;
              }),
        ));
