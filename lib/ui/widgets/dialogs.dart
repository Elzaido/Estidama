import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/ui/widgets/my_orders_widgets.dart';
import '../../constants/colors.dart';
import 'interface_components.dart';

void showVerificationDialog(
    context, name, phone, password, registerController) {
  showDialog(
      context: context,
      builder: (context1) => AlertDialog(
            title: const Text(
              'تأكيد رقم الهاتف',
              textAlign: TextAlign.right,
              style:
                  TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
            ),
            content: Obx(() => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "لقد تم استخدام رقم تحقق للتجربة وذلك نظرا لان التطبيق في حالة التجربة",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Image.asset("assets/verification_img.gif"),
                    if (registerController.isLoading.value == true) loading()
                  ],
                )),
            actions: <Widget>[
              // Expanded(child: Container()),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'إغلاق',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: alertColor,
                        ),
                      )),
                  const SizedBox(
                    width: 30,
                  ),
                  MaterialButton(
                    color: mainColor,
                    onPressed: () {
                      // var registerController = Get.put(RegisterController());
                      registerController.signUpProcess(
                        name,
                        phone,
                        registerController.selectedProvince.value,
                        registerController.isMaleSelected.value == true
                            ? "male"
                            : "female",
                        password,
                      );
                    },
                    child: Text(
                      "حسنا",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ));
}

void showComplainInfoDialog(
    context, complainModel, myComplainsController, index) {
  Size size = MediaQuery.of(context).size;
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
                          index, true, context1, 1, size),
                      const SizedBox(
                        width: 10,
                      ),
                      complainModel.complainAccepetanceStatus == "rejected"
                          ? activityState('تم رفض الشكوى', size)
                          : complainModel.complainAccepetanceStatus == "pending"
                              ? activityState('الشكوى قيد الدراسة', size)
                              : activityState("تم قبول الشكوى", size)
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
  Size size = MediaQuery.of(context).size;
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
                            fontFamily: "Cairo",
                          ),
                        ),
                        const Text(
                          ' :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text('نوع المادة',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Cairo",
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
                            fontFamily: "Cairo",
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
                              fontFamily: "Cairo",
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
                          index, true, context1, 3, size),
                      const SizedBox(
                        width: 10,
                      ),
                      recyclingModel.recyclingAcepetanceStatus == "rejected"
                          ? activityState('تم رفض الطلب', size)
                          : recyclingModel.recyclingAcepetanceStatus ==
                                  "pending"
                              ? activityState('الطلب قيد الدراسة', size)
                              : activityState("تم قبول الطلب", size)
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

String formatNames(String names) {
  final nameList = names.trim().split(
      RegExp(r'\s+|,\s*')); // Split by spaces or commas with optional spaces
  final formattedNames = <String>[];
  for (var i = 0; i < nameList.length; i += 4) {
    final name1 = i < nameList.length ? nameList[i] : '';
    final name2 = (i + 1) < nameList.length ? nameList[i + 1] : '';
    final name3 = (i + 2) < nameList.length ? nameList[i + 2] : '';
    final name4 = (i + 3) < nameList.length ? nameList[i + 3] : '';

    formattedNames.add('$name1 $name2 $name3 $name4: المتطوع ${i ~/ 4 + 1}');
  }
  return formattedNames.join('\n'); // Join with newline for line breaks
}

void showVolunteeringDialog(
    context, volunteerModel, myComplainsController, index) {
  Size size = MediaQuery.of(context).size;
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
                                  fontFamily: "Cairo",
                                  fontSize: 15,
                                ),
                              ),
                              const Text(
                                ' :',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Cairo",
                                ),
                              ),
                              const Text('عمل التطوع',
                                  style: TextStyle(
                                    fontFamily: "Cairo",
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
                                  fontFamily: "Cairo",
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
                                    fontFamily: "Cairo",
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
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "اسماء المتطوعين",
                            style: TextStyle(
                              fontFamily: "Cairo",
                            ),
                          ),
                          Container(
                            width: double.maxFinite,
                            constraints: const BoxConstraints(maxHeight: 150),
                            child: Text(
                                //  formatNames(
                                //   volunteerModel.volunteersNames.toString()
                              volunteerModel.volunteersNames.toString(),
                              // formatNames(
                              //     volunteerModel.volunteersNames.toString()),
                              style: const TextStyle(
                                fontFamily: "Cairo",
                              ),
                            ),
                          )
                        ],
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
                          index, true, context1, 2, size),
                      const SizedBox(
                        width: 10,
                      ),
                      volunteerModel.isVolunteeringAccepted == "rejected"
                          ? activityState('تم رفض الطلب', size)
                          : volunteerModel.isVolunteeringAccepted == "pending"
                              ? activityState('الطلب قيد الدراسة', size)
                              : activityState('تم قبول الطلب', size),
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
