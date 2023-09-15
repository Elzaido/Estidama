import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/ui/widgets/shimmer_widget1.dart';
import 'package:madenati/ui/widgets/separator_widget.dart';
import '../../widgets/mycomplain_widget.dart';

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
              if (!snapshot.hasData) {
                return noComplainsCenterdTitle();
              }
              if (snapshot.data['data'].length == null) {
                return noComplainsCenterdTitle();
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
                return noComplainsCenterdTitle();
              } else {
                if (snapshot.hasData) {
                  controller.complainLength.value =
                      snapshot.data['data'].length;
                  return snapshot.data.length != 0
                      ? Obx(() => Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ListView.separated(
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
                                            ComplainsModel.fromJson(
                                                complainData))
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
              }
            } catch (e) {
              log(e.hashCode);
            }
            return noComplainsCenterdTitle();
          }),
    );
  }

  Widget noComplainsCenterdTitle() {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'لم تقم بتقديم أي شكوى حتى الآن',
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
