import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:madenati/constants/colors.dart';
import 'package:madenati/controllers/complains_controller.dart';
import 'package:madenati/ui/widgets/add_location_widget.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';
import 'package:madenati/ui/widgets/button_widget.dart';
import 'package:madenati/ui/widgets/complain_form_titles.dart';
import 'package:madenati/ui/widgets/dropdown_widget.dart';
import '../../widgets/desc_formfield_widget.dart';
import '../../widgets/formfield_widget.dart';

class Complains extends StatelessWidget {
  Complains({super.key});
//
  final dateControl = TextEditingController();
  final descControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ComplainsController controller = Get.find();
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
                  Obx(() => dropDown(
                      selected: controller.selectedComplain.value,
                      list: controller.complainsList,
                      onChanged: (newValue) {
                        controller.changeCompalin(newValue);
                        controller.selectedComplain.value = newValue!;
                      })),
                  title(text: 'ما هي درجة خطورة البلاغ'),
                  Obx(() => dropDown(
                      selected: controller.selectedStatus.value,
                      list: controller.complainStatus,
                      onChanged: (newValue) {
                        controller.changeStatus(newValue);
                        controller.selectedStatus.value = newValue!;
                      })),
                  descFormField(
                      hint: 'أخبرنا المزيد ...', controller: descControl),
                  formField(
                    ontap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2030-01-01'))
                          .then((value) {
                        dateControl.text = DateFormat.yMMMd().format(value!);
                      });
                    },
                    readOnly: true,
                    control: dateControl,
                    isScure: false,
                    label: 'تاريخ البلاغ',
                    prefIcon: const Icon(Icons.date_range_outlined),
                    validator: (String? v) {
                      if (v!.isEmpty) {
                        return 'Date must not be empty';
                      }
                      return null;
                    },
                  ),
                  addLocation(
                      image: 'assets/location.png',
                      title: 'حدد الموقع على الخريطة',
                      context: context),
                  button(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context1) => AlertDialog(
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
                                            onPressed: () {
                                              controller
                                                  .pickComplainImageFromCamera();
                                              Navigator.pop(context1, true);
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('إلتقط صورة',
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo')),
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
                                              controller
                                                  .pickComplainImageFromGallery();
                                              Navigator.pop(context1, true);
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'إختر من المعرض',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo'),
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt),
                          SizedBox(
                            width: 5,
                          ),
                          Text('أضف صورة')
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  if (controller.complainImage != null)
                    Stack(
                      children: [
                        Container(
                            height: 400,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                ),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        FileImage(controller.complainImage!)))),
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
                                    controller.removePostImage();
                                  },
                                  icon: const Icon(Icons.close)),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
