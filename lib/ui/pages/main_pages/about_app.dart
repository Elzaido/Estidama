import 'package:flutter/material.dart';
import 'package:madenati/constants/texts.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';
import '../../widgets/gradiant_image_widget.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});
  @override
  AboutAppState createState() => AboutAppState();
}

class AboutAppState extends State<AboutApp> {
  double imageOpacity = 0.0;
  double textOpacity = 0.0;

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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: defaultAppBar(context: context, title: 'نبذة عن التطبيق'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnimatedOpacity(
                opacity: imageOpacity,
                duration: const Duration(milliseconds: 500),
                child: gradientImage(
                  image: 'assets/about.png',
                ),
              ),
              AnimatedOpacity(
                opacity: textOpacity,
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
