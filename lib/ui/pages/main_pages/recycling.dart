// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/colors.dart';
import 'package:madenati/controllers/recycling_controller.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';
import 'package:madenati/ui/widgets/button_widget.dart';
import 'package:madenati/ui/widgets/complain_form_titles.dart';
import 'package:madenati/ui/widgets/dropdown_widget.dart';
import 'package:madenati/ui/widgets/formfield_widget.dart';
import '../../widgets/add_location_widget.dart';

class Recycling extends StatelessWidget {
  Recycling({super.key});
//
  final dateControl = TextEditingController();
  final itemWeightcontroller = TextEditingController();
  var geographicLocationData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    RecyclingController recyclingController = Get.find();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: defaultAppBar(context: context, title: 'إعادة التدوير'),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  title(text: 'ما هو نوع المادة'),
                  Obx(
                    () => dropDown(
                        selected: recyclingController
                            .selectedRecyclingItem.value
                            .toString(),
                        list: recyclingController.recyclingItemList,
                        FLAG: 2),
                  ),
                  formField(
                    control: itemWeightcontroller,
                    isScure: false,
                    label: 'وزن المادة المراد إعادة تدويرها',
                    prefIcon: const Icon(Icons.numbers),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يجب إدخال وزن المادة';
                      } else {
                        return null;
                      }
                    },
                  ),
                  addLocation(
                      image: "assets/location.png",
                      title: "أضف موقعك",
                      context: context),
                  pickImageWidget(
                    size,
                    recyclingController,
                    context,
                  ),
                  Obx(() => recyclingController.isShowImage.value != 1
                      ? imagePlacerHolderWidget(recyclingController)
                      : const Text(" ")),
                  button(
                      onPressed: () {
                        recyclingController.checkRecyclingItemsData(
                            recyclingController.descriptionController.text,
                            geographicLocationData);
                      },
                      child: const Text(
                        "إرسال",
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
    RecyclingController recyclingController,
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
                              recyclingController
                                  .pickRecyclingItemImageFromCamera();
                              Navigator.pop(context1, true);
                              recyclingController.isShowImage.value = 1;
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
                              recyclingController
                                  .pickRecyclingItemImageFromGallery();
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

  Widget imagePlacerHolderWidget(RecyclingController recyclingController) {
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
                  image: FileImage(recyclingController.recyclingItemImage!))),
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
                    recyclingController.removeRecyclingItemImage();
                  },
                  icon: const Icon(Icons.close)),
            ),
          ),
        ),
      ],
    );
  }
}
