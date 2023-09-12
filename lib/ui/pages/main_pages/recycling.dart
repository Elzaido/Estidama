import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/texts.dart';
import 'package:madenati/controllers/recycling_controller.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';
import 'package:madenati/ui/widgets/button_widget.dart';
import '../../widgets/add_location_widget.dart';
import '../../widgets/gradiant_image_widget.dart';

class Recycling extends StatefulWidget {
  const Recycling({super.key});
  @override
  RecyclingState createState() => RecyclingState();
}

class RecyclingState extends State<Recycling> {
  RecyclingController recyclingController = Get.find();

  @override
  void initState() {
    super.initState();
    recyclingController.loading();
  }  
    

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: defaultAppBar(context: context, title: 'إعادة التدوير'),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedOpacity(
                  opacity: recyclingController.imageOpacity.value,
                  duration: const Duration(milliseconds: 500),
                  child: gradientImage(
                    image: 'assets/recycling.png',
                  ),
                ),
                AnimatedOpacity(
                  opacity: recyclingController.textOpacity.value,
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      recyclingText,
                      style: const TextStyle(fontSize: 16, fontFamily: 'Cairo'),
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                AnimatedOpacity(
                    opacity: recyclingController.buttonOpacity.value,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: button(
                          onPressed: () {
                            Get.toNamed('/recyclingform');
                          },
                          child: const Text(
                            'تقديم طلب إعادة تدوير',
                            style: TextStyle(fontFamily: 'Cairo'),
                          )),
                    )),
                AnimatedOpacity(
                    opacity: recyclingController.buttonOpacity.value,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: locationWidget(
                        title: 'عرض نقاط إعادة التدوير على الخريطة',
                        context: context,
                        size: size,
                        whichPage: 3,
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
