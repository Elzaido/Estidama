import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/texts.dart';
import 'package:madenati/controllers/volunteering_controller.dart';
import '../../widgets/interface_components.dart';
import 'package:madenati/ui/widgets/complain_form_titles.dart';
import '../../widgets/gradiant_image_widget.dart';

class Volunteering extends StatefulWidget {
  const Volunteering({super.key});
  @override
  VolunteeringState createState() => VolunteeringState();
}

class VolunteeringState extends State<Volunteering> {
  TextEditingController volunteenurNumberController = TextEditingController();
  VolunteeringController volunteeringController = Get.find();
  TextEditingController volunteerNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    volunteeringController.loading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: defaultAppBar(context: context, title: 'التقديم للعمل التطوعي'),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedOpacity(
                  opacity: volunteeringController.imageOpacity.value,
                  duration: const Duration(milliseconds: 500),
                  child: gradientImage(
                    image: 'assets/volunteering.png',
                  ),
                ),
                AnimatedOpacity(
                  opacity: volunteeringController.textOpacity.value,
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      volunteeringText,
                      style: const TextStyle(fontSize: 16, fontFamily: 'Cairo'),
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                AnimatedOpacity(
                    opacity: volunteeringController.buttonOpacity.value,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: button(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (
                                  context1,
                                ) =>
                                    showVolunteeringDialog(
                                        volunteeringController,
                                        context1,
                                        volunteenurNumberController,
                                        volunteerNameController));
                          },
                          child: const Text(
                            'تقديم طلب التطوع',
                            style: TextStyle(fontFamily: 'Cairo'),
                          )),
                    )),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }

  Widget showVolunteeringDialog(
      VolunteeringController volunteeringController,
      context1,
      TextEditingController volunteenurNumberController,
      TextEditingController volunteerNameController) {
    Size size = MediaQuery.of(context1).size;
    return AlertDialog(
      title: const Text(
        'تقديم طلب تطوع',
        style: TextStyle(
          fontFamily: 'Cairo',
        ),
        textAlign: TextAlign.end,
      ),
      content: SizedBox(
        width: size.width * 0.9,
        child: SingleChildScrollView(
          child: Column(
            children: [
              title(text: 'نوع التطوع').paddingOnly(left: 10, right: 10),
              Obx(
                () => dropDown(
                        selected: volunteeringController
                            .selectedVolunteringType.value
                            .toString(),
                        list: volunteeringController.volunteringTypeList,
                        flag: 5)
                    .paddingSymmetric(horizontal: 10),
              ),
              title(text: 'جهة التطوع').paddingOnly(left: 10, right: 10),
              Obx(
                () => dropDown(
                        selected: volunteeringController
                            .selectedVolunteringGroup.value
                            .toString(),
                        list: volunteeringController.volunteringGroupList,
                        flag: 6)
                    .paddingSymmetric(
                  horizontal: 10,
                ),
              ),
              title(text: 'عدد الأشخاص المشاركين في التطوع'),
              TextFormField(
                onChanged: (value) {
                  // setState(() {
                  // Update the number of volunteers when the user enters a value.
                  volunteeringController.volunteenerNumber.value =
                      int.tryParse(value) ?? 0;
                  // });
                },
                decoration: InputDecoration(
                  isDense: true,
                  hintTextDirection: TextDirection.rtl,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'عدد المشاركين',
                  hintStyle: const TextStyle(fontFamily: 'Cairo'),
                ),
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.rtl,
                controller: volunteenurNumberController,
              ).paddingAll(10),
              if (volunteeringController.volunteenerNumber.value > 0)
                SizedBox(
                  height: size.height *
                      0.18, // Specify a fixed height, adjust as needed
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: volunteeringController.volunteenerNumber.value,
                    itemBuilder: (context, index) {
                      final label = 'إسم المشترك ${index + 1} الرباعي';
                      return TextFormField(
                        // controller: volunteerNameController,
                        decoration: InputDecoration(
                          isDense: true,
                          hintTextDirection: TextDirection.rtl,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: label,
                          hintStyle: const TextStyle(fontFamily: 'Cairo'),
                        ),
                        onChanged: (value) {
                          volunteeringController.volunteersSeparateName +=
                              value.toString();
                          log(volunteeringController.volunteersSeparateName);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يجب إدخال $label';
                          } else {
                            return null;
                          }
                        },
                        textDirection: TextDirection.rtl,
                      ).paddingAll(10);
                    },
                  ),
                ),
              button(
                  onPressed: () => volunteeringController
                      .checkVolunteerData(volunteenurNumberController),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('إرسال', style: TextStyle(fontFamily: 'Cairo')),
                      SizedBox(width: 10),
                      Icon(Icons.send_sharp),
                    ],
                  )).paddingAll(10),
              buttonDismiss(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
                      SizedBox(width: 10),
                      Text(
                        'X',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    ],
                  )).paddingAll(10),
              // if ,
            ],
          ),
        ),
      ),
    );
  }
}
