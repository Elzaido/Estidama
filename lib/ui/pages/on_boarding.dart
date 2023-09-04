import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/boardingmodel.dart';
import '../../db/local/shared_preference.dart';
import '../widgets/onboarding_widget.dart';
// import 'authentication/login.dart';

// ignore: must_be_immutable
class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  OnBoardingController controller = Get.find();
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/onboarding1.png',
      title: 'معاً لبيئة أفضل',
    ),
    BoardingModel(
      image: 'assets/onboarding3.png',
      title: 'ساهم في إعادة التدوير',
    ),
    BoardingModel(
      image: 'assets/onboarding2.png',
      title: 'شارك معنا في العمل التطوعي',
    ),
  ];

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Get.offNamed("/login");
        // controller.navigateAndFinish(
        //     context: context, widget: const LoginPage());
      }
    });
  }

  var boardController = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                },
                child: const Text(
                  'تخطي',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: 18,
                  ),
                )),
            const SizedBox(
              width: 5,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Expanded(
                // PageView means that i have many pages in one page :
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index) {
                    // if the index equal the index of the last page then :
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      boardingItemBuilder(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
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
                        if (isLast) {
                          submit();
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
              )
            ],
          ),
        ));
  }
}
