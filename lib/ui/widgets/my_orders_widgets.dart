// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/controllers/recycling_controller.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/models/recycling_model.dart';
import 'package:madenati/models/volunteer_model.dart';
import 'package:madenati/ui/widgets/dialogs.dart';
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
                    print(complainModel.complain_accepetance_status);
                    showComplainInfoDialog(
                        context, complainModel, myComplainsController, index);
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

                    complainModel.complain_accepetance_status == "rejected"
                        ? activityState('تم رفض الشكوى')
                        : complainModel.complain_accepetance_status == "pending"
                            ? activityState('الشكوى قيد الدراسة')
                            : activityState("تم قبول الشكوى")

                    // ,    activityState('الشكوى قيد الدراسة')
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
    case 'تم قبول الشكوى':
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

Widget deleteItemButton(dynamic model, MyComplainsController myComplainsController,
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
          } else {
            myComplainsController.deleteRecyclingOrder(
                model.volunteerId.toString(), index);
          }
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
                    
                  },
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            volunteerModel.volunteeringType == "1"
                                ? 'نظافة'
                                : 'رعاية الحيوانات',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('  /  '),
                          Text(
                            volunteerModel.volunteerGroupType == "1"
                                ? 'مدرسة'
                                : volunteerModel.volunteerGroupType == " 2"
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
                     volunteerModel.is_voluteering_accepted == "rejected"
                        ? activityState('تم رفض الطلب')
                        : volunteerModel.is_voluteering_accepted ==
                                "pending"
                            ? activityState('الطلب قيد الدراسة')
                            : activityState('تم قبول الطلب'),
                  ],
                ),
              ],
            ),
          )));
}

Widget myrecyclingItem(context, RecyclingModel recyclingModel,
    MyComplainsController myComplainsController, index) {
  RecyclingController recyclingController = Get.find();
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
                    // print(recyclingModel.rec);
                    showComplainInfoDialog(
                        context, recyclingModel, myComplainsController, index);
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
                              recyclingController.fromIntToTextRecyclingItem(
                                  int.parse("${recyclingModel.materialType}")),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 17,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              recyclingModel.orderDate.toString(),
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
                            "$complainImages/${recyclingModel.materialImg.toString()}",
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
                    // deleteComplainButton(complainModel, myComplainsController,
                    //     index, false, context),

                    deleteItemButton(recyclingModel, myComplainsController,
                        index, false, context, 3),
                    const SizedBox(
                      width: 30,
                    ),

                    recyclingModel.recycling_accepetance_status == "rejected"
                        ? activityState('تم رفض الطلب')
                        : recyclingModel.recycling_accepetance_status ==
                                "pending"
                            ? activityState('الطلب قيد الدراسة')
                            : activityState('تم قبول الطلب'),
                  ],
                ),
              ],
            ),
          )));
}

Widget noComplainsCenterdTitle() {
  return const Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'لا يوجد معلومات لعرضها',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13,
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Icon(
          Icons.warning,
          color: Colors.red,
          size: 27,
        )
      ],
    ),
  );
}
 

snapShotExceptionHandling(snapshot, size) async {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return await homeShimmerWidget(size: size);
  }
  if (snapshot.data['data'].length == null) {
    return noComplainsCenterdTitle();
  }
  if (snapshot.hasError) {
    return const Center(
      child: Text(
        "حدث خطأ ما.",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  if (snapshot.hasError) {
    return const Center(
      child: Text(
        "حدث خطأ ما.",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
