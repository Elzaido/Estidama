import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/ui/widgets/my_orders_widgets.dart';

import 'interface_components.dart';

void showComplainInfoDialog(
    context, complainModel, myComplainsController, index) {
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
                    complainModel.complainDescription.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      deleteItemButton(complainModel, myComplainsController,
                          index, true, context1, 1),
                      const SizedBox(
                        width: 10,
                      ),
                      complainModel.complainAccepetanceStatus == "rejected"
                          ? activityState('تم رفض الشكوى')
                          : complainModel.complainAccepetanceStatus == "pending"
                              ? activityState('الشكوى قيد الدراسة')
                              : activityState("تم قبول الشكوى")
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
}

void showRecyclingInfoDialog(context, recyclingModel, myComplainsController,
    recyclingController, index) {
  showDialog(
      context: context,
      builder: (context1) => AlertDialog(
            title: const Text(
              'تفاصيل طلب إعادة التدوير',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Cairo',
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          recyclingController.fromIntToTextRecyclingItem(
                              int.parse("${recyclingModel.materialType}")),
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const Text(
                          ' :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text('نوع المادة',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'كيلو ',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${recyclingModel.materialWeight}',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const Text(
                          ' :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text('وزن المادة',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 300,
                    height: 300,
                    child: Image(
                      image: NetworkImage(
                        "$complainImages/${recyclingModel.materialImg.toString()}",
                      ),
                      fit: BoxFit.cover,
                    ))
              ],
            ),
            actions: <Widget>[
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      deleteItemButton(recyclingModel, myComplainsController,
                          index, true, context1, 3),
                      const SizedBox(
                        width: 10,
                      ),
                      recyclingModel.recyclingAcepetanceStatus == "rejected"
                          ? activityState('تم رفض الشكوى')
                          : recyclingModel.recyclingAcepetanceStatus ==
                                  "pending"
                              ? activityState('الشكوى قيد الدراسة')
                              : activityState("تم قبول الشكوى")
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
}

void showVoluteeringInfoDialog(
    context, volunteerModel, myComplainsController, index, size) {
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                volunteerModel.volunteeringType == 1
                                    ? 'عمليات تنظيف'
                                    : 'رعاية الحيوانات',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const Text(
                                ' :',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Text('عمل التطوع',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                volunteerModel.volunteerGroupType == 1
                                    ? 'مدرسة'
                                    : volunteerModel.volunteerGroupType == 2
                                        ? 'أهل الحي'
                                        : 'جمعية خيرية',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const Text(
                                ' :',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Text('جهة التطوع',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
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
                        constraints: const BoxConstraints(maxHeight: 150),
                        child: ListView.builder(
                          itemCount: 5, // Replace with your actual item count.
                          itemBuilder: (context, index) {
                            // Build your list items here.
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'إسم المتطوع ${index + 1}: زيد رائد ربحي',
                                  textDirection: TextDirection.rtl,
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
                      deleteItemButton(volunteerModel, myComplainsController,
                          index, true, context1, 2),
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
}

class Dialogs {
  Color greenC = const Color.fromARGB(255, 141, 203, 141);
  late Size size;
  void successDialog(String successMsg, BuildContext context,
      String description, String imgLink) {
    size = MediaQuery.of(context).size;

    Get.defaultDialog(
        titlePadding: const EdgeInsets.all(30),
        backgroundColor: Colors.transparent,
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(begin: Alignment.topLeft, colors: [
                Color.fromRGBO(64, 18, 139, 1),
                Color.fromRGBO(147, 54, 180, 1)
              ])),
          width: size.width * 0.7,
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              Image.asset(
                imgLink,
                width: size.width * 0.35,
                height: size.height * 0.22,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                width: size.width * 0.5,
                child: Text(
                  successMsg,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.45,
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: greenC,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          )),
        )).then((value) => 2);
  }
}
