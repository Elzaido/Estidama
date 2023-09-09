import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/ui/widgets/separator_widget.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/mycomplain_widget.dart';

class MyComplains extends StatelessWidget {
  const MyComplains({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MyComplainsController controller = Get.find();
    return SafeArea(
      child: Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'بلاغاتي', isHome: true),
          body:
              //  controller.myComplains.isNotEmpty
              //     ?
              Container(
            width: size.width,
            height: size.height,
            child: FutureBuilder(
                future: controller.retriveCurrentUserComplains(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  }

                  try {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: Text("لايوجد بلاغات حتى الآن"));
                    }
                    if (snapshot.data['data'].length == null) {
                      return const Center(
                        child: Text("لايوجد بلاغات"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "حدث خطأ ما.",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text(
                          "لايوجد بلاغات حتى الآن.",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      );
                    } else {
                      if (snapshot.hasData) {
                        return snapshot.data.length != 0
                            ? ListView.separated(
                                itemCount: controller.complainList.length,
                                separatorBuilder: (context, index) =>
                                    separator(),
                                itemBuilder: (context, index) {
                                  if (snapshot.data['data'][index].length !=
                                      0) {
                                    controller.complainList.value = snapshot
                                        .data['data']
                                        .map<ComplainsModel>((complainData) =>
                                            ComplainsModel.fromJson(
                                                complainData))
                                        .toList();

// print(snapshot.data['data'][index]['complain_id']);
                                    return Obx(() => controller
                                            .complainList.isNotEmpty
                                        ? myComplainItem(
                                            context,
                                            controller.complainList[index],
                                            controller,
                                            index
                                            // ComplainsModel.fromJson(
                                            //     snapshot.data['data'][index]),
                                            // controller

                                            )
                                        :const Center(
                                            child: Text(
                                              "لايوجد بلاغات حتى الآن.",
                                            ),
                                          ));
                                  }
                                  return const Center(
                                      child: Text("لايوجد بلاغات حتى الآن"));
                                })
                            : const Center(
                                child: Center(
                                    child: Text("لايوجد بلاغات حتى الآن")));
                      }
                    }
                  } catch (e) {
                    log(e.hashCode);
                  }
                  return const Center(child: Text("لايوجد بلاغات حتى الآن"));
                }),
          )),
    );
    // : NoComplainsCenterdTitle());
  }

  Widget NoComplainsCenterdTitle() {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'لم تقم بتقديم أي بلاغ حتى الآن',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 7,
          ),
          Icon(
            Icons.warning,
            color: Colors.red,
            size: 30,
          )
        ],
      ),
    );
  }
}
