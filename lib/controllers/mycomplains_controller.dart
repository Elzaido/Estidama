// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/local/shared_preference.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/models/recycling_model.dart';
import 'package:madenati/models/volunteer_model.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';
// import '../constants/hotlinks.dart';

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

  deleteComplain(complainId, index) async {
    var response =
        await postRequest(deleteComplainLink, {"complain_id": "$complainId"});

    if (response['status'] == 'success') print("yess");
    complainList.removeAt(index);
    complainLength.value--;
    defaultToast(massage: "تم حذف الشكوى بنجاح", state: ToastStates.SUCCESS);
    update();
    return response;
  }

  //SOON
  deleteVolunteer(volunteerId, index) async {
    var response = await postRequest(
        delteVolunteerRequestLink, {"volunteer_id": "$volunteerId"});

    if (response['status'] == 'success') print("yess");
    volunteerList.removeAt(index);
    volunteerLength.value--;
    defaultToast(massage: "تم حذف الشكوى بنجاح", state: ToastStates.SUCCESS);
    update();
    return response;
  }

  // This Function not working properly ... check it bro
  deleteRecyclingOrder(recyclerId, index) async {
    var response = await postRequest(
        delteRecyclingrRequestLink, {"recycler_id": "$recyclerId"});

    if (response['status'] == 'success') print("yess");
    recyclingList.removeAt(index);
    recyclingLength.value--;
    defaultToast(massage: "تم حذف الطلب بنجاح", state: ToastStates.SUCCESS);
    update();
    return response;
  }

  retriveCurrentUserVolunteeringOrders() async {
    var response = await postRequest(getCurrentUserVolunteeringOrders,
        {"user_id": CacheHelper.getData(key: "user_id").toString()});

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
}
