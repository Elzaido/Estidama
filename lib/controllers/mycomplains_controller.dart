// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/local/shared_preference.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';
// import '../constants/hotlinks.dart';

class MyComplainsController extends GetxController {
  RxBool isComplain = true.obs;

  void changeIsComplain() {
    isComplain.value = !isComplain.value;
  }

  RxList<ComplainsModel> complainList = [ComplainsModel()].obs;
  RxInt complainLength = 0.obs;
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
    defaultToast(massage: "تم حذف البلاغ بنجاح", state: ToastStates.SUCCESS);
    update();
    return response;
  }

  retriveCurrentUserVolunteeringOrders() async {
    var response = await postRequest(getCurrentUserVolunteeringOrders,
        {"user_id": CacheHelper.getData(key: "user_id").toString()});

    if (response['status'] == 'success') {
      print("success");
    }
    if (response['status'] == 'faild') {
      print("faild");
    }
    return response;
  }

  
}
