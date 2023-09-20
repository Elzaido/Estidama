// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/models/recycling_model.dart';
import 'package:madenati/ui/widgets/interface_components.dart';
import 'package:madenati/ui/widgets/mycomplain_widgets.dart';

class MyRecyclingReq extends StatelessWidget {
  MyRecyclingReq({super.key});
// THIS PAGE IS CONNECTED TO THE MYT COMPLAINS CONTROLLER
// MYRecycling AND MYCOMPLAINS AND RECYCLING ORDERS BELONG TO THE MY COMPLAINS CONTROLLER
  MyComplainsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
        width: size.width,
        height: size.height,
        child: FutureBuilder(
            future: controller.retriveCurrentUserRecyclingOrders(),
            builder: ((BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return homeShimmerWidget(size: size);
              }
              if (snapshot.data['data'].length == null) {
                return noComplainsCenterdTitle();
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "حدث خطأ ما.",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              }
              try {
                if (snapshot.hasData) {
                  controller.recyclingLength.value= snapshot.data['data'].length;

                  return snapshot.data.length != 0
                      ? Obx(() => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                itemCount: controller.recyclingLength.value,
                                itemBuilder: (context, index) {
                                  if (snapshot.data['data'][index].length !=
                                      0) {
                                    controller.recyclingList.value = snapshot
                                        .data['data']
                                        .map<RecyclingModel>((recyclingdata) =>
                                            RecyclingModel.fromJson(
                                                recyclingdata))
                                        .toList();
                                    return Obx(() =>
                                        controller.recyclingList.isNotEmpty
                                            ? myrecyclingItem(
                                                context,
                                                controller.recyclingList[index],
                                                controller,
                                                index)
                                            : noComplainsCenterdTitle());
                                  }
                                  return noComplainsCenterdTitle();
                                }),
                          ))
                      : noComplainsCenterdTitle();
                }
              } catch (e) {
                log(e.hashCode);
              }

              return noComplainsCenterdTitle();
            })));
  }
}
