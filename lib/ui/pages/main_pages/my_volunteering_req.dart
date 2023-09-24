import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/models/volunteer_model.dart';
import 'package:madenati/ui/widgets/interface_components.dart';
import 'package:madenati/ui/widgets/my_orders_widgets.dart';

class MyVolunteeringReq extends StatelessWidget {
  const MyVolunteeringReq({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MyComplainsController controller = Get.find();
    return SizedBox(
      width: size.width,
      height: size.height,
      child: FutureBuilder(
        future: controller.retriveCurrentUserVolunteeringOrders(),
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return homeShimmerWidget(size: size);
          }
          try {
            snapShotExceptionHandling(snapshot, size);

            if (snapshot.hasData) {
              controller.volunteerList.value = snapshot.data['data']
                  .map<VolunteerModel>(
                      (complainData) => VolunteerModel.fromJson(complainData))
                  .toList();
              return Obx(() => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.volunteerList.length,
                    itemBuilder: (context, index) {
                      return Obx(() => controller.volunteerList.isNotEmpty
                          ? volunteerItem(
                              context,
                              controller.volunteerList[index],
                              controller,
                              index,
                              size)
                          : noOrdersCenterdTitle('لا يوجد طلبات لعرضها'));
                    },
                  ));
            }
          } catch (exe) {
            return noOrdersCenterdTitle('لا يوجد طلبات لعرضها');
          }
          return noOrdersCenterdTitle('لا يوجد طلبات لعرضها');
        }),
      ),
    );
  }
}
