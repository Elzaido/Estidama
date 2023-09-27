// ignore_for_file: avoid_print

import 'dart:math';
import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/local/shared_preference.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/models/recycling_model.dart';
import 'package:madenati/models/volunteer_model.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';

class MyComplainsController extends GetxController {
  RxInt selectedPage = 0.obs;

  void changeSelectedPage(int index) {
    selectedPage.value = index;
  }

  List<ComplainsModel> complainList = [ComplainsModel()];
  RxList<VolunteerModel> volunteerList = [VolunteerModel()].obs;
  RxList<RecyclingModel> recyclingList = [RecyclingModel()].obs;

  RxInt complainLength = 0.obs;
  RxInt volunteerLength = 0.obs;
  RxInt recyclingLength = 0.obs;

  // List<Map> myComplainsList = [];
  // RxList myComplains = [].obs;
  retriveCurrentUserComplains() async {
    var response = await postRequest(retriveUserComplainsLink,
        {"complainer_id": CacheHelper.getData(key: "user_id").toString()});

    if (response['status'] == 'success') {
      print("success");
    }
    if (response['status'] == 'faild') {
      print("faild");
    }
    return response;
  }

  deleteComplain(complainId, index, String complain_image_path) async {
    var response = await postRequest(deleteComplainLink, {
      "complain_id": "$complainId",
      "complain_image_path": complain_image_path
    });
    Get.forceAppUpdate();

    if (response['status'] == 'success') print("yess");

    defaultToast(massage: "تم حذف الشكوى بنجاح", state: ToastStates.SUCCESS);
  }

  //SOON
  deleteVolunteer(volunteering_id, index) async {
    var response = await postRequest(
        delteVolunteerRequestLink, {"volunteering_id": "$volunteering_id"});
    if (response != null) {
      if (response['status'] == 'success') {
        print("yess");
        defaultToast(massage: "تم حذف الطلب بنجاح", state: ToastStates.SUCCESS);
      } else if (response['status'] == 'faild') {
        // Handle the case where 'status' is not 'success'
        defaultToast(massage: "لم يتم حذف الطلب ", state: ToastStates.SUCCESS);
      }
    } else {
      // Handle the case where response is null
      print("Failed to delete order: response is null");
    }
    Get.forceAppUpdate();
  }

  deleteRecyclingOrder(
      recyclerId, index, String recycling_material_image_path) async {
    var response = await postRequest(delteRecyclingrRequestLink, {
      "order_id": "$recyclerId",
      "material_img": recycling_material_image_path
    });
    Get.forceAppUpdate();
    if (response != null) {
      if (response['status'] == 'success') {
        defaultToast(massage: "تم حذف الطلب بنجاح", state: ToastStates.SUCCESS);
      } else if (response['status'] == 'faild') {
        // Handle the case where 'status' is not 'success'
        defaultToast(massage: "لم يتم حذف الطلب ", state: ToastStates.SUCCESS);
      }
    } else {
      // Handle the case where response is null
      print("Failed to delete order: response is null");
    }
  }

  retriveCurrentUserVolunteeringOrders() async {
    var response = await postRequest(getCurrentUserVolunteeringOrders,
        {"leader_id": CacheHelper.getData(key: "user_id").toString()});

    if (response['status'] == 'success') {
      print("lg");
      return response;
    }
    if (response['status'] == 'faild') {
      print("faild");
    }
    return response;
  }

  retriveCurrentUserRecyclingOrders() async {
    var response = await postRequest(getCurrentUserRecyclingOrders,
        {"recycler_id": CacheHelper.getData(key: "user_id").toString()});

    if (response['status'] == 'success') {
      print("retrived recycling orders");
      return response;
    }
    if (response['status'] == 'faild') {
      print("faild");
    }
    return response;
  }

  //volunteering split name from database functions:
  // bool isThereSpace(String name) {
  //   bool isThere = false;

  //   for (var i = 0; i < name.length; i++) {
  //     if (name[i] == ' ') {
  //       isThere = true;
  //     }
  //   }

  //   return isThere;
  // }

  int volunteersCount(String name) {
//// ahmad khaled samer
    int i = 0;
    int counter = 0;
    for (i; i < name.length; i++) {
      if (name[i] == ' ') {
      } else {
        counter++;
      }
    }
    log(counter);
    return counter;
  }
}
