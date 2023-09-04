import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:madenati/controllers/complains_controller.dart';
import 'package:madenati/ui/pages/main_pages/googlemaps.dart';
import 'package:madenati/ui/widgets/add_location_widget.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';
import 'package:madenati/ui/widgets/button_widget.dart';
import 'package:madenati/ui/widgets/complain_form_titles.dart';
import 'package:madenati/ui/widgets/dropdown_widget.dart';
import '../../widgets/desc_formfield_widget.dart';
import '../../widgets/formfield_widget.dart';

class Complains extends StatelessWidget {
  Complains({super.key});

  final dateControl = TextEditingController();

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
                  dropDown(
                      selected: controller.selectedComplain,
                      list: controller.complainsList),
                  title(text: 'ما هي درجة خطورة البلاغ'),
                  dropDown(
                      selected: controller.selectedStatus,
                      list: controller.complainStatus),
                  descFormField(hint: 'أخبرنا المزيد ...'),
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
                        
 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapScreen()),
              );                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt),
                          SizedBox(
                            width: 5,
                          ),
                          Text('أضف صورة')
                        ],
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
