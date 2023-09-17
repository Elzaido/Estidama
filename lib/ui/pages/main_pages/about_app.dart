import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/texts.dart';
import 'package:madenati/controllers/about_app_controller.dart';
import '../../widgets/interface_components.dart';
import '../../widgets/gradiant_image_widget.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});
  @override
  AboutAppState createState() => AboutAppState();
}

class AboutAppState extends State<AboutApp> {
  AboutAppController controller = Get.find();
  @override
  void initState() {
    super.initState();
    controller.loading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'نبذة عن التطبيق'),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnimatedOpacity(
                opacity: controller.imageOpacity.value,
                duration: const Duration(milliseconds: 500),
                child: gradientImage(
                  image: 'assets/about.png',
                ),
              ),
              AnimatedOpacity(
                opacity: controller.textOpacity.value,
                duration: const Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    aboutAppText,
                    style: const TextStyle(fontSize: 16, fontFamily: 'Cairo'),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
