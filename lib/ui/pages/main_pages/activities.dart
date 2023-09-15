// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/ui/pages/main_pages/my_volunteering_req.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';
import 'my_complains.dart';

class Activities extends StatelessWidget {
  Activities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    MyComplainsController myComplainsController = Get.find();
    return Scaffold(
        appBar: defaultAppBar(context: context, title: 'نشاطاتي', isHome: true),
        body: Obx(
          () => Column(
            children: [
              Container(
                height: size.height*0.11,
                decoration: BoxDecoration(color: Colors.grey[100], boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 15, right: 7.5, bottom: 15),
                        child: GestureDetector(
                          onTap: () {
                            myComplainsController.changeIsComplain();
                          },
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                color: myComplainsController.isComplain.value
                                    ? Colors.green[400]
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                'الشكاوي',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                  fontSize: 18,
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
                            top: 15, left: 7.5, right: 15, bottom: 15),
                        child: GestureDetector(
                          onTap: () {
                            myComplainsController.changeIsComplain();
                          },
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                color: myComplainsController.isComplain.value
                                    ? Colors.grey
                                    : Colors.green[400],
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                'طلبات التطوع',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              myComplainsController.isComplain.value
                  ? Expanded(child: MyComplains())
                  : Expanded(child: MyVolunteeringReq())
            ],
          ),
        ));
  }
}
