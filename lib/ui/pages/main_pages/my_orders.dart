import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/ui/widgets/my_orders_widgets.dart';
import '../../widgets/interface_components.dart';

class MyComplains extends StatelessWidget {
  const MyComplains({super.key});

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
                    ? Obx(() => Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.complainLength.value,
                              separatorBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: separator(),
                                  ),
                              itemBuilder: (context, index) {
                                if (snapshot.data['data'][index].length != 0) {
                                  controller.complainList.value = snapshot
                                      .data['data']
                                      .map<ComplainsModel>((complainData) =>
                                          ComplainsModel.fromJson(complainData))
                                      .toList();
                                  return Obx(() =>
                                      controller.complainList.isNotEmpty
                                          ? myComplainItem(
                                              context,
                                              controller.complainList[index],
                                              controller,
                                              index)
                                          : noOrdersCenterdTitle(
                                              'لا يوجد شكاوي لعرضها'));
                                }
                                return noOrdersCenterdTitle(
                                    'لا يوجد شكاوي لعرضها');
                              }),
                        ))
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
