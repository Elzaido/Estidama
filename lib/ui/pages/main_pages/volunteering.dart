import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/texts.dart';
import 'package:madenati/controllers/volunteering_controller.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';
import 'package:madenati/ui/widgets/button_widget.dart';
import 'package:madenati/ui/widgets/complain_form_titles.dart';
import 'package:madenati/ui/widgets/dropdown_widget.dart';
import 'package:madenati/ui/widgets/formfield_widget.dart';
import '../../widgets/gradiant_image_widget.dart';

class Volunteering extends StatefulWidget {
  const Volunteering({super.key});
  @override
  VolunteeringState createState() => VolunteeringState();
}

class VolunteeringState extends State<Volunteering> {
  TextEditingController skills_controller = TextEditingController();
  VolunteeringController volunteeringController = Get.find();

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
                                      skills_controller,
                                    ));
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
    TextEditingController skills_controller,
  ) {
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
                        FLAG: 5)
                    .paddingSymmetric(horizontal: 10),
              ),
              title(text: 'جهة التطوع').paddingOnly(left: 10, right: 10),
              Obx(
                () => dropDown(
                        selected: volunteeringController
                            .selectedVolunteringGroup.value
                            .toString(),
                        list: volunteeringController.volunteringGroupList,
                        FLAG: 6)
                    .paddingSymmetric(
                  horizontal: 10,
                ),
              ),
              title(text: ' ماهي مهاراتك'),
              formField(
                  control: skills_controller,
                  isScure: false,
                  label: "مهارات المتطوع",
                  prefIcon: const Icon(Icons.volunteer_activism),
                  validator: (val) {
                    return "";
                  }).paddingAll(10),
              button(
                  onPressed: () => volunteeringController
                      .checkVolunteerData(skills_controller),
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
            ],
          ),
        ),
      ),
    );
  }
}
