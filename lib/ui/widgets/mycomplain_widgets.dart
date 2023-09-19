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
                                        deleteComplainButton(
                                            complainModel,
                                            myComplainsController,
                                            index,
                                            true,
                                            context1),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        complainState('الشكوى قيد الدراسة')
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
                        child:
                            // complainModel.complainImagePath == ""
                            //     ?
                            Image(
                          image: NetworkImage(
                            "$complainImages/${complainModel.complainImagePath.toString()}",
                          ),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                        // : const Icon(
                        //     Icons.photo,
                        //     size: 50,
                        //     color: Colors.green,
                        //   ),
                        ),
                  ]),
                ),
                separator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    deleteComplainButton(complainModel, myComplainsController,
                        index, false, context),
                    const SizedBox(
                      width: 30,
                    ),
                    complainState('الشكوى قيد الدراسة')
                  ],
                ),
              ],
            ),
          )));
}

Widget complainState(String state) {
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

Widget deleteComplainButton(
        ComplainsModel complainModel,
        MyComplainsController myComplainsController,
        index,
        bool indialog,
        context1) =>
    Container(
        width: 140,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          onTap: () {
            if (indialog) Navigator.pop(context1, true);
            log(complainModel.complainId.toString());
            myComplainsController.deleteComplain(
                complainModel.complainId.toString(), index);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                'إلغاء الشكوى',
                style: TextStyle(
                    fontFamily: 'Cairo', color: Colors.white, fontSize: 12),
              )
            ],
          ),
        ));

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
                                      Text(volunteerModel.volunteeringType
                                          .toString()),
                                      Text(volunteerModel.volunteerGroupType
                                          .toString()),
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
                                              children: [
                                                Text(
                                                  'إسم المتطوع $index',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context1, true);
                                          myComplainsController.deleteVolunteer(
                                              volunteerModel.volunteerId
                                                  .toString(),
                                              index);
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
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      complainState('تم قبول الطلب')
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
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            volunteerModel.volunteerSkills.toString(),
                            maxLines: 2,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.photo,
                      size: 50,
                      color: Colors.green,
                    ),
                  ),
                ]),
              ),
              separator(),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      // log(complainModel.complainId.toString());
                      myComplainsController.deleteVolunteer(
                          volunteerModel.volunteerId.toString(), index);
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