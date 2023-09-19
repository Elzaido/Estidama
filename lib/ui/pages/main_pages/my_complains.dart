import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/ui/widgets/mycomplain_widgets.dart';
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
                                  if (snapshot.data['data'][index].length !=
                                      0) {
                                    controller.complainList.value = snapshot
                                        .data['data']
                                        .map<ComplainsModel>((complainData) =>
                                            ComplainsModel.fromJson(
                                                complainData))
                                        .toList();
                                    return Obx(() =>
                                        controller.complainList.isNotEmpty
                                            ? 
                                             myComplainItem(
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

    
  Widget noComplainsCenterdTitle() {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'لا يوجد شكاوي لعرضها',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
            ),
          ),
          SizedBox(
            width: 7,
          ),
          Icon(
            Icons.warning,
            color: Colors.red,
            size: 27,
          )
        ],
      ),
    );
  }
}
