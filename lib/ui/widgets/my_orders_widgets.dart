// ignore_for_file: unrelated_type_equality_checks, avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/controllers/myorders_controller.dart';
import 'package:madenati/controllers/recycling_controller.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/models/recycling_model.dart';
import 'package:madenati/models/volunteer_model.dart';
import 'package:madenati/ui/widgets/dialogs.dart';
import 'interface_components.dart';

Widget myComplainItem(context, ComplainsModel complainModel,
    MyComplainsController myComplainsController, int index, Size size) {
  print(index);
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
                    log('${complainModel.complainAccepetanceStatus}');
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
                    complainModel.complainImagePath != null
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image(
                              image: NetworkImage(
                                "$complainImages/${complainModel.complainImagePath.toString()}",
                              ),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ))
                        : const SizedBox(),
                  ]),
                ),
                separator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    deleteItemButton(complainModel, myComplainsController,
                        index, false, context, 1, size),
                    const SizedBox(
                      width: 20,
                    ),
                    complainModel.complainAccepetanceStatus == "rejected"
                        ? activityState('تم رفض الشكوى', size)
                        : complainModel.complainAccepetanceStatus == "pending"
                            ? activityState('الشكوى قيد الدراسة', size)
                            : activityState("تم قبول الشكوى", size)
                  ],
                ),
              ],
            ),
          )));
}

Widget activityState(String state, Size size) {
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
    width: size.width * 0.33,
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

Widget deleteItemButton(
        dynamic model,
        MyComplainsController myComplainsController,
        int index,
        bool indialog,
        context1,
        int whichPage,
        Size size) =>
    SizedBox(
      height: 50,
      width: size.width * 0.35,
      child: ElevatedButton(
        onPressed: () {
          if (indialog) Navigator.pop(context1, true);
          if (whichPage == 1) {
            print(index);
            myComplainsController.deleteComplain(
                model.complainId.toString(), index, model.complainImagePath);
          } else if (whichPage == 2) {
            myComplainsController.deleteVolunteer(
                model.volunteeringId.toString(), index);
            log(model.volunteeringId);
          } else if (whichPage == 3) {
            print("============================");
            myComplainsController.deleteRecyclingOrder(
                model.orderId.toString(), index, model.materialImg);
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
            whichPage == 1
                ? const Text(
                    'إلغاء الشكوى',
                    style: TextStyle(
                        fontFamily: 'Cairo', color: Colors.white, fontSize: 12),
                  )
                : const Text(
                    'إلغاء الطلب',
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
                    showVolunteeringDialog(
                        context, volunteerModel, myComplainsController, index);
                  },
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
                          fontFamily: "Cairo",
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
                          fontFamily: "Cairo",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                separator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    deleteItemButton(volunteerModel, myComplainsController,
                        index, false, context, 2, size),
                    const SizedBox(
                      width: 20,
                    ),
                    volunteerModel.isVolunteeringAccepted == "rejected"
                        ? activityState('تم رفض الطلب', size)
                        : volunteerModel.isVolunteeringAccepted == "pending"
                            ? activityState('الطلب قيد الدراسة', size)
                            : activityState('تم قبول الطلب', size),
                  ],
                ),
              ],
            ),
          )));
}

Widget myrecyclingItem(context, RecyclingModel recyclingModel,
    MyComplainsController myComplainsController, index, Size size) {
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
                    showRecyclingInfoDialog(
                      context,
                      recyclingModel,
                      myComplainsController,
                      recyclingController,
                      index,
                    );
                  },
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          recyclingController.fromIntToTextRecyclingItem(
                              int.parse("${recyclingModel.materialType}")),
                          style: const TextStyle(
                            fontSize: 17,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
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
                    const SizedBox(
                      width: 15,
                    ),
                    Image(
                      image: NetworkImage(
                        "$complainImages/${recyclingModel.materialImg.toString()}",
                      ),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ]),
                ),
                separator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    deleteItemButton(recyclingModel, myComplainsController,
                        index, false, context, 3, size),
                    const SizedBox(
                      width: 20,
                    ),
                    recyclingModel.recyclingAcepetanceStatus == "rejected"
                        ? activityState('تم رفض الطلب', size)
                        : recyclingModel.recyclingAcepetanceStatus == "pending"
                            ? activityState('الطلب قيد الدراسة', size)
                            : activityState('تم قبول الطلب', size),
                  ],
                ),
              ],
            ),
          )));
}

Widget noOrdersCenterdTitle(String title) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 15,
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        const Icon(
          Icons.warning,
          color: Colors.red,
          size: 30,
        )
      ],
    ),
  );
}

snapShotExceptionHandling(snapshot, size) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return homeShimmerWidget(size: size);
  }
  if (snapshot.data['data'].length == null) {
    return noOrdersCenterdTitle('حدث خطأ ما');
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
