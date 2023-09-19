// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/models/volunteer_model.dart';
import 'interface_components.dart';

Widget myComplainItem(context, ComplainsModel complainModel,
    MyComplainsController myComplainsController, index) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(16.0), // Adjust the radius as needed
            color: Colors.white,
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context1) => AlertDialog(
                              title: const Text(
                                'تفاصيل الشكوى',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      complainModel.complainDescription
                                          .toString(),
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: Image(
                                        image: NetworkImage(
                                          "$complainImages/${complainModel.complainImagePath.toString()}",
                                        ),
                                        fit: BoxFit.cover,
                                      ))
                                ],
                              ),
                              actions: <Widget>[
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        deleteItemButton(
                                            complainModel,
                                            myComplainsController,
                                            index,
                                            true,
                                            context1,
                                            1),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        activityState('الشكوى قيد الدراسة')
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context1, true);
                                        },
                                        child: const Text(
                                          'إغلاق',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ));
                  },
                  child:
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              textDirection: TextDirection.rtl,
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
                        child: Image(
                          image: NetworkImage(
                            "$complainImages/${complainModel.complainImagePath.toString()}",
                          ),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )),
                  ]),
                ),
                separator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    deleteItemButton(complainModel, myComplainsController,
                        index, false, context, 1),
                    const SizedBox(
                      width: 30,
                    ),
                    activityState('الشكوى قيد الدراسة')
                  ],
                ),
              ],
            ),
          )));
}

Widget volunteerItem(context, VolunteerModel volunteerModel,
    MyComplainsController myComplainsController, index, Size size) {
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context1) => AlertDialog(
                              title: const Text(
                                'تفاصيل طلب التطوع',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              content: SizedBox(
                                  width: size.width * 0.9,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  volunteerModel
                                                              .volunteeringType ==
                                                          1
                                                      ? 'عمليات تنظيف'
                                                      : 'رعاية الحيوانات',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const Text(
                                                  ' :',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Text('عمل التطوع',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  volunteerModel
                                                              .volunteerGroupType ==
                                                          1
                                                      ? 'مدرسة'
                                                      : volunteerModel
                                                                  .volunteerGroupType ==
                                                              2
                                                          ? 'أهل الحي'
                                                          : 'جمعية خيرية',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const Text(
                                                  ' :',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Text('جهة التطوع',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        separator(),
                                        Container(
                                          width: double.maxFinite,
                                          constraints: const BoxConstraints(
                                              maxHeight: 150),
                                          child: ListView.builder(
                                            itemCount:
                                                5, // Replace with your actual item count.
                                            itemBuilder: (context, index) {
                                              // Build your list items here.
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'إسم المتطوع ${index + 1}: زيد رائد ربحي',
                                                    textDirection:
                                                        TextDirection.rtl,
                                                  ),
                                                  separator()
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              actions: <Widget>[
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        deleteItemButton(
                                            volunteerModel,
                                            myComplainsController,
                                            index,
                                            true,
                                            context1,
                                            2),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        activityState('تم قبول الطلب')
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context1, true);
                                        },
                                        child: const Text(
                                          'إغلاق',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ));
                  },
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            volunteerModel.volunteeringType == 1
                                ? 'عمليات تنظيف'
                                : 'رعاية الحيوانات',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('  /  '),
                          Text(
                            volunteerModel.volunteerGroupType == 1
                                ? 'مدرسة'
                                : volunteerModel.volunteerGroupType == 2
                                    ? 'أهل الحي'
                                    : 'جمعية خيرية',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                separator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    deleteItemButton(volunteerModel, myComplainsController,
                        index, false, context, 2),
                    const SizedBox(
                      width: 30,
                    ),
                    activityState('تم قبول الطلب')
                  ],
                ),
              ],
            ),
          )));
}

Widget activityState(String state) {
  Color backgroundColor;
  switch (state) {
    case 'الشكوى قيد الدراسة':
      backgroundColor = Colors.orange;
      break;
    case 'تم رفض الشكوى':
      backgroundColor = Colors.red;
      break;
    case 'تم مراجعة الشكوى':
      backgroundColor = Colors.green;
    case 'الطلب قيد الدراسة':
      backgroundColor = Colors.orange;
      break;
    case 'تم رفض الطلب':
      backgroundColor = Colors.red;
      break;
    case 'تم قبول الطلب':
      backgroundColor = Colors.green;

      break;
    default:
      backgroundColor = Colors.transparent; // Default color for unknown states
      break;
  }

  return Container(
    width: 140,
    height: 50,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(
        state,
        style: const TextStyle(
            fontFamily: 'Cairo', color: Colors.white, fontSize: 12),
      ),
    ),
  );
}

Widget deleteItemButton(model, MyComplainsController myComplainsController,
        index, bool indialog, context1, int whichPage) =>
    SizedBox(
      height: 50,
      width: 140,
      child: ElevatedButton(
        onPressed: () {
          if (indialog) Navigator.pop(context1, true);
          if (whichPage == 1) {
            log(model.complainId.toString());
            myComplainsController.deleteComplain(
                model.complainId.toString(), index);
          } else if (whichPage == 2) {
            myComplainsController.deleteVolunteer(
                model.volunteerId.toString(), index);
          } else {}
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Set the background color to red
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            const SizedBox(
              width: 3,
            ),
            whichPage == 1
                ? const Text(
                    'إلغاء الشكوى',
                    style: TextStyle(
                        fontFamily: 'Cairo', color: Colors.white, fontSize: 12),
                  )
                : const Text(
                    'إلغاء الطلب ',
                    style: TextStyle(
                        fontFamily: 'Cairo', color: Colors.white, fontSize: 12),
                  )
          ],
        ),
      ),
    );
