// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/colors.dart';
import 'package:madenati/controllers/complains_controller.dart';
import '../../widgets/interface_components.dart';
import 'package:madenati/ui/widgets/complain_form_titles.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';
import '../../widgets/add_location_widget.dart';

class Complains extends StatelessWidget {
  Complains({super.key});

  final dateControl = TextEditingController();
  var geographicLocationData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    ComplainsController complainsController = Get.find();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: defaultAppBar(context: context, title: 'تقديم شكوى'),
        body: Obx(() => Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          title(text: 'ما هو نوع شكوى'),
                          Obx(
                            () => dropDown(
                                selected: complainsController
                                    .selectedComplain.value
                                    .toString(),
                                list: complainsController.complainsList,
                                flag: 2),
                          ),
                          title(text: 'ما هي درجة خطورة الشكوى'),
                          Obx(
                            () => dropDown(
                                selected: complainsController
                                    .selectedComplainStatus.value
                                    .toString(),
                                list: complainsController.complainStatus,
                                flag: 3),
                          ),
                          descFormField(
                              hint: 'الرجاء ذكر تفاصيل أكثر عن الشكوى ...',
                              textController:
                                  complainsController.descriptionController),
                          Obx(() => complainsController.locationSelected.value
                              ? locationSelectedWidget(
                                  context: context, whichPage: 1, size: size)
                              : locationWidget(
                                  title: "إضافة موقع الشكوى",
                                  context: context,
                                  whichPage: 1,
                                  size: size)),
                          pickImageWidget(
                            size,
                            complainsController,
                            context,
                          ),
                          Obx(() => complainsController.isShowImage.value != 1
                              ? imagePlacerHolderWidget(complainsController)
                              : const Text(" ")),
                          button(
                              onPressed: () {
                                if (geographicLocationData != null) {
                                  complainsController.checkComplainsData(
                                    complainsController
                                        .descriptionController.text,
                                    geographicLocationData
                                        .toString(), // Ensure it's a string
                                  );
                                } else {
                                  // Handle the case where geographicLocationData is null.
                                  defaultToast(
                                      massage: 'الرجاء تحديد الموقع مرة أخرى',
                                      state: ToastStates.WARNING);
                                }
                              },
                              child: const Text(
                                "إرسال الشكوى",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Cairo"),
                              )),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                if (complainsController.isLoading.value) loading()
              ],
            )));
  }

  Widget pickImageWidget(
    size,
    ComplainsController complainsController,
    context,
  ) {
    return InkWell(
        onTap: () async {
          showDialog(
              context: context,
              builder: (
                context1,
              ) =>
                  AlertDialog(
                      title: const Text(
                        'أضف صورة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                        ),
                        textAlign: TextAlign.end,
                      ),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: button(
                              //choosing image  from camera
                              onPressed: () {
                                // complainsController.isShowImage.value = 0;
                                complainsController
                                    .pickComplainImageFromCamera();
                                Navigator.pop(context1, true);
                                complainsController.isShowImage.value = 1;
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('إلتقط صورة',
                                      style: TextStyle(fontFamily: 'Cairo')),
                                  SizedBox(width: 5),
                                  Icon(Icons.camera),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: button(
                              onPressed: () {
                                // complainsController.isShowImage.value = 0;
                                complainsController
                                    .pickComplainImageFromGallery();
                                Navigator.pop(context1, true);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'إختر من المعرض',
                                    style: TextStyle(fontFamily: 'Cairo'),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.image),
                                ],
                              )),
                        ),
                      ]));
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green)),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'أضف صورة',
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: "Cairo",
                  ),
                ),
                Icon(
                  Icons.add_a_photo,
                  color: Colors.green,
                )
              ],
            ),
          ),
        ));
  }

  Widget imagePlacerHolderWidget(ComplainsController complainsController) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Stack(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(complainsController.complainImage!))),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: mainColor,
                radius: 20,
                child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      complainsController.removePostImage();
                    },
                    icon: const Icon(Icons.close)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
