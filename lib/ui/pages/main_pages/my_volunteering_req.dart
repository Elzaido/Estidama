 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/models/volunteer_model.dart';
import 'package:madenati/ui/widgets/interface_components.dart';
import 'package:madenati/ui/widgets/mycomplain_widgets.dart';
 
class MyVolunteeringReq extends StatelessWidget {
  const MyVolunteeringReq({super.key});
// THIS PAGE IS CONNECTED TO THE MYT COMPLAINS CONTROLLER
// MYVOLUNTEERING AND MYCOMPLAINS AND RECYCLING ORDERS BELONG TO THE MY COMPLAINS CONTROLLER

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MyComplainsController controller = Get.find();
    return Center(
        child: Expanded(
      child: FutureBuilder(
          future: controller.retriveCurrentUserVolunteeringOrders(),
          builder: ((context, AsyncSnapshot snapshot) {
            try {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return homeShimmerWidget(size: size);
              }
              if (snapshot.connectionState == ConnectionState.none) {
               loading();
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
                          ?  
                          volunteerItem(
                              context,
                              controller.volunteerList[index],
                              controller,
                              index,
                              size)

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
            'لا يوجد طلبات تطوع لعرضها',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
            ),
          ),
          SizedBox(
            width: 7,
          ),
          Icon(Icons.warning, color: Colors.red, size: 27)
        ],
      ),
    );
  }
}
