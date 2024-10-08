// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/boardingmodel.dart';
 import '../widgets/interface_components.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});

  OnBoardingController controller = Get.find();
  var boardController = PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/Grid3.png',
      title:'التطبيق الاول لوزارة البيئة',
      // 'معاً لبيئة أفضل'
    ),
    BoardingModel(
        image: 'assets/Grid1.png', title: 'قدم الشكاوي المتعلقة بالبيئة'),
    BoardingModel(
      image: 'assets/Grid4.png',
      title: 'ساهم في إعادة التدوير',
    ),
    BoardingModel(
      image: 'assets/Grid2.png',
      title: 'شارك معنا في العمل التطوعي',
    ),
  ];

  


  @override
  Widget build(BuildContext context) {
    OnBoardingController onBoardingController = Get.find();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: boardController,
          onPageChanged: (int index) {
            // if the index equal the index of the last page then :
            if (index == boarding.length - 1) {
              onBoardingController.isLast.value = true;
            } else {
              onBoardingController.isLast.value = false;
            }
          },
          itemBuilder: (context, index) =>
              boardingItemBuilder(boarding[index], size),
          itemCount: boarding.length,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: TextButton(
                onPressed: () {
                 controller. submit();
                },
                child: const Text(
                  'تخطي',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: 20,
                  ),
                )),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.white,
                    activeDotColor: Colors.green,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: () {
                      if (onBoardingController.isLast.value) {
                         controller. submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
