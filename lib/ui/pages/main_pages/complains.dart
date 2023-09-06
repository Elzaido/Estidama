// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/complains_controller.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';
import 'package:madenati/ui/widgets/button_widget.dart';
import 'package:madenati/ui/widgets/complain_form_titles.dart';
import 'package:madenati/ui/widgets/dropdown_widget.dart';
import '../../widgets/add_location_widget.dart';
import '../../widgets/desc_formfield_widget.dart';

class Complains extends StatelessWidget {
  Complains({super.key});
//
  final dateControl = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  var geographicLocationData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    ComplainsController complainsController = Get.find();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: defaultAppBar(context: context, title: 'تقديم بلاغ'),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  title(text: 'ما هو نوع البلاغ'),
                  Obx(
                    () => dropDown(
                        selected: complainsController.selectedComplain.value
                            .toString(),
                        list: complainsController.complainsList,
                        FLAG: 2),
                  ),
                  title(text: 'ما هي درجة خطورة البلاغ'),
                  Obx(
                    () => dropDown(
                        selected: complainsController
                            .selectedComplainStatus.value
                            .toString(),
                        list: complainsController.complainStatus,
                        FLAG: 3),
                  ),
                  descFormField(
                      hint: 'الرجاء ذكر تفاصيل عن البلاغ مثل عنوان أو مكان',
                      textController:
                          complainsController.descriptionController),
                  addLocation(
                      image: "assets/location.png",
                      title: "اضافة موقع",
                      context: context),
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
                        complainsController.checkComplainsData(
                            complainsController.descriptionController.text,
                            geographicLocationData);
                      },
                      child: const Text(
                        "ارسال الشكوى",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: "Cairo"),
                      )).paddingAll(5),
                ],
              ),
            ),
          ),
        ));
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
                              complainsController.pickComplainImageFromCamera();
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
        width: size.width * 0.9,
        height: 40,
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
      ).paddingAll(5),
    );
  }

  Widget imagePlacerHolderWidget(ComplainsController complainsController) {
    return Stack(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(complainsController.complainImage!))),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
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
    );
  }
}
