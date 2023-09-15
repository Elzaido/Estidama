import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';

class MyVolunteeringReq extends StatelessWidget {
    MyVolunteeringReq({super.key});
// THIS PAGE IS CONNECTED TO THE MYT COMPLAINS CONTROLLER
// MYVOLUNTEERING AND MYCOMPLAINS AND RECYCLING ORDERS BELONG TO THE MY COMPLAINS CONTROLLER
  MyComplainsController complainsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
            future: complainsController.retriveCurrentUserVolunteeringOrders(),
            builder: ((context, snapshot) {
              return Expanded(
                  child: ListView.builder(itemBuilder: (  (context1, index) {
                    return  ;
                  })));
            })));
  }
}
