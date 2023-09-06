import 'package:flutter/material.dart';
import 'package:madenati/constants/texts.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';
import 'package:madenati/ui/widgets/button_widget.dart';
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
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        textOpacity = 1.0; // Set opacity to fully opaque (1.0) for fade-in.
      });
    });
    // Animate opacity for the button after a longer delay.
    Future.delayed(const Duration(milliseconds: 1300), () {
      setState(() {
        buttonOpacity = 1.0; // Set opacity to fully opaque (1.0) for fade-in.
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
                      child: const Text(
                        'تقديم طلب التطوع',
                        style: TextStyle(fontFamily: 'Cairo'),
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
