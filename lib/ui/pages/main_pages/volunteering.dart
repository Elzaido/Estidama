import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/texts.dart';
import 'package:madenati/controllers/volunteering_controller.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';
import 'package:madenati/ui/widgets/button_widget.dart';
import 'package:madenati/ui/widgets/complain_form_titles.dart';
import 'package:madenati/ui/widgets/dropdown_widget.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';
import '../../widgets/gradiant_image_widget.dart';

class Volunteering extends StatefulWidget {
  const Volunteering({super.key});
  @override
  VolunteeringState createState() => VolunteeringState();
}

class VolunteeringState extends State<Volunteering> {
  double imageOpacity = 0.0;
  double textOpacity = 0.0;
  double buttonOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Animate opacity for the image after a short delay.
    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        imageOpacity = 1.0; // Set opacity to fully opaque (1.0) for fade-in.
      });
    });
    // Animate opacity for the text after a slightly longer delay.
    Future.delayed(const Duration(milliseconds: 1100), () {
      setState(() {
        textOpacity = 1.0; // Set opacity to fully opaque (1.0) for fade-in.
      });
    });
    // Animate opacity for the button after a longer delay.
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        buttonOpacity = 1.0; // Set opacity to fully opaque (1.0) for fade-in.
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    VolunteeringController volunteeringController = Get.find();
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'التقديم للعمل التطوعي'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: imageOpacity,
              duration: const Duration(milliseconds: 500),
              child: gradientImage(
                image: 'assets/volunteering.png',
              ),
            ),
            AnimatedOpacity(
              opacity: textOpacity,
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
                opacity: buttonOpacity,
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
                                AlertDialog(
                                    title: const Text(
                                      'تقديم طلب تطوع',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 11),
                                        child: title(text: 'نوع التطوع'),
                                      ),
                                      Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: dropDown(
                                              selected: volunteeringController
                                                  .selectedVolunteringType.value
                                                  .toString(),
                                              list: volunteeringController
                                                  .volunteringTypeList,
                                              FLAG: 5),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: button(
                                            onPressed: () {
                                              Navigator.pop(context1, true);
                                              defaultToast(
                                                  massage:
                                                      'تم إرسال الطلب بنجاح',
                                                  state: ToastStates.SUCCESS);
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('إرسال',
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo')),
                                                SizedBox(width: 10),
                                                Icon(Icons.send_sharp),
                                              ],
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: button(
                                            onPressed: () {
                                              Navigator.pop(context1, true);
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('إلغاء',
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo')),
                                                SizedBox(width: 10),
                                                Text(
                                                  'X',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                )
                                              ],
                                            )),
                                      ),
                                    ]));
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
    );
  }
}
