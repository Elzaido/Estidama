import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/ui/widgets/my_orders.dart';
import 'package:shimmer/shimmer.dart';

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
          }),
    );
  }

  Widget separator() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: (Container(
          height: 1,
          color: const Color.fromARGB(255, 226, 226, 226),
        )),
      );

  Widget homeShimmerWidget({required Size size}) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.separated(
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => separator(),
                itemCount: 5)),
      );
}
