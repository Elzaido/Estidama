// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/ui/pages/main_pages/my_volunteering_req.dart';
import '../../widgets/interface_components.dart';
import 'my_orders.dart';
import 'my_recycling_req.dart';

class Activities extends StatelessWidget {
  Activities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MyComplainsController myComplainsController = Get.find();

    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'نشاطاتي', isHome: true),
      body: Column(
        children: [
          Container(
            height: size.height * 0.11,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 10, right: 5, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            myComplainsController.changeSelectedPage(0);
                          },
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color:
                                  myComplainsController.selectedPage.value == 0
                                      ? Colors.green[400]
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'الشكاوي',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 5, right: 5, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            myComplainsController.changeSelectedPage(1);
                          },
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color:
                                  myComplainsController.selectedPage.value == 1
                                      ? Colors.green[400]
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'طلبات التطوع',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 5, right: 10, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            myComplainsController.changeSelectedPage(2);
                          },
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color:
                                  myComplainsController.selectedPage.value == 2
                                      ? Colors.green[400]
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'طلبات إعادة التدوير',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Expanded(
            child: Obx(() => IndexedStack(
                  index: myComplainsController.selectedPage.value,
                  children: [
                    MyComplains(),
                    MyVolunteeringReq(),
                    MyRecyclingReq(),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
