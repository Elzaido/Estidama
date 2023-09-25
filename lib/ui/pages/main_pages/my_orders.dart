// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/myorders_controller.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/ui/widgets/my_orders_widgets.dart';
import '../../widgets/interface_components.dart';

class MyComplains extends StatefulWidget {
  const MyComplains({super.key});

  @override
  State<MyComplains> createState() => _MyComplainsState();
}

class _MyComplainsState extends State<MyComplains> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MyComplainsController controller = Get.find();
    return SizedBox(
      width: size.width,
      height: size.height,
      child: FutureBuilder(
          future: controller.retriveCurrentUserComplains(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return homeShimmerWidget(size: size);
            }
            try {
              snapShotExceptionHandling(snapshot, size);

              if (snapshot.hasData) {
                controller.complainLength.value = snapshot.data['data'].length;
                return snapshot.data.length != 0
                    ? Obx(() => controller.complainLength.value != 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data['data']
                                    .length, // controller.complainLength.value,
                                itemBuilder: (context, int index) {
                                  print("index: ++++== $index");

                                  if (snapshot.data['data'][index].length !=
                                      0) {
                                    controller.complainList = snapshot
                                        .data['data']
                                        .map<ComplainsModel>((complainData) =>
                                            ComplainsModel.fromJson(
                                                complainData))
                                        .toList();
                                    return controller.complainList.isNotEmpty
                                        ? myComplainItem(
                                            context,
                                            ComplainsModel.fromJson(snapshot
                                                    .data['data'][
                                                index]), //controller.complainList[index]
                                            controller,
                                            index,
                                            size)
                                        : noOrdersCenterdTitle(
                                            'لا يوجد شكاوي لعرضها');
                                  }
                                  return noOrdersCenterdTitle(
                                      'لا يوجد شكاوي لعرضها');
                                }),
                          )
                        : const SizedBox())
                    : noOrdersCenterdTitle('لا يوجد شكاوي لعرضها');
              }
            } catch (e) {
              log(e.hashCode);
            }
            return noOrdersCenterdTitle('لا يوجد شكاوي لعرضها');
          }),
    );
  }
}
