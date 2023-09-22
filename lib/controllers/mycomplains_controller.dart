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

  RxList<ComplainsModel> complainList = [ComplainsModel()].obs;
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

    if (response['status'] == 'success') print("yess");
    complainList.removeAt(index);
    complainLength.value--;
    defaultToast(massage: "تم حذف الشكوى بنجاح", state: ToastStates.SUCCESS);
    update();
    return response;
  }

  //SOON
  deleteVolunteer(String volunteering_id, index) async {
    var response = await postRequest(
        delteVolunteerRequestLink, {"volunteering_id": "$volunteering_id"});

    if (response['status'] == 'success') volunteerList.removeAt(index);
    volunteerLength.value--;
    defaultToast(massage: "تم حذف الطلب بنجاح", state: ToastStates.SUCCESS);
    update();
    return response;
  }

  deleteRecyclingOrder(
      recyclerId, index, String recycling_material_image_path) async {
    var response = await postRequest(delteRecyclingrRequestLink, {
      "recycler_id": "$recyclerId",
      "material_img": recycling_material_image_path
    });

    if (response != null) {
      if (response['status'] == 'success') {
        print("yess");
        recyclingList.removeAt(index);
        recyclingLength.value--;
        defaultToast(massage: "تم حذف الطلب بنجاح", state: ToastStates.SUCCESS);
        update();
      } else {
        // Handle the case where 'status' is not 'success'
        print("Failed to delete order");
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
  bool isThereSpace(String name) {
    bool isThere = false;

    for (var i = 0; i < name.length; i++) {
      if (name[i] == ' ') {
        isThere = true;
      }
    }

    return isThere;
  }

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
