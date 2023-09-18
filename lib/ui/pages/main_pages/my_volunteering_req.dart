// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/models/volunteer_model.dart';
import 'package:madenati/ui/widgets/interface_components.dart';
import 'package:madenati/ui/widgets/mycomplain_widgets.dart';

class MyVolunteeringReq extends StatelessWidget {
  MyVolunteeringReq({super.key});
// THIS PAGE IS CONNECTED TO THE MYT COMPLAINS CONTROLLER
// MYVOLUNTEERING AND MYCOMPLAINS AND RECYCLING ORDERS BELONG TO THE MY COMPLAINS CONTROLLER
  MyComplainsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Expanded(
      child: FutureBuilder(
          future: controller.retriveCurrentUserVolunteeringOrders(),
          builder: ((context, AsyncSnapshot snapshot) {
            try {
              if (snapshot.connectionState == ConnectionState.waiting) {
                loading();
              }
              if (snapshot.connectionState == ConnectionState.none) {
                // loading();
                return noComplainsCenterdTitle();
              }

              if (snapshot.hasData) {
                controller.volunteerList.value = snapshot.data['data']
                    .map<VolunteerModel>(
                        (complainData) => VolunteerModel.fromJson(complainData))
                    .toList();
                return Obx(() => ListView.builder(
                    itemCount: controller.volunteerList.length,
                    itemBuilder: (context, index) {
                      return Obx(() => controller.volunteerList.isNotEmpty
                          ? volunteerItem(
                              context,
                              controller.volunteerList[index],
                              controller,
                              index)
                          : noComplainsCenterdTitle());
                    }));
              }
            } catch (exe) {
              return noComplainsCenterdTitle();
            }
            return noComplainsCenterdTitle();
          })),
    ));
  }

  Widget noComplainsCenterdTitle() {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'لم تقم بتقديم أي طلب تطوع حتى الآن',
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
