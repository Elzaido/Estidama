import 'package:get/get.dart';

class AboutAppController extends GetxController {
  RxDouble imageOpacity = 0.0.obs;
  RxDouble textOpacity = 0.0.obs;

  void loading() {
    Future.delayed(const Duration(milliseconds: 700), () {
      imageOpacity.value =
          1.0; // Set opacity to fully opaque (1.0) for fade-in.
    });
    // Animate opacity for the text after a slightly longer delay.
    Future.delayed(const Duration(milliseconds: 1100), () {
      textOpacity.value = 1.0; // Set opacity to fully opaque (1.0) for fade-in.
    });
  }
}
