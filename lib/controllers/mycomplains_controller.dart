import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/db/local/shared_preference.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/models/mycomplains_model.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';
// import '../constants/hotlinks.dart';

class MyComplainsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  RxBool isComplain = true.obs;

  void changeIsComplain() {
    isComplain.value = !isComplain.value;
  }

  RxList<ComplainsModel> complainList = [ComplainsModel()].obs;
  RxInt complain_length = 0.obs;
  // List<Map> myComplainsList = [];
  // RxList myComplains = [].obs;
  retriveCurrentUserComplains() async {
    var response = await postRequest(retriveUserComplainsLink,
        {"complainer_id": CacheHelper.getData(key: "user_id").toString()});

    if (response['status'] == 'success') {
      print("ggggggggggg");
    }
    if (response['status'] == 'faild') {
      print("eeeeeeeeeee");
    }
    return response;
  }

  deleteComplain(complainId, index) async {
    var response =
        await postRequest(deleteComplainLink, {"complain_id": "$complainId"});

    if (response['status'] == 'success') print("yess");
    // complainList.value.(index);
    complainList.removeAt(index);
    complain_length.value--;
    defaultToast(massage: "تم حذف البلاغ بنجاح", state: ToastStates.SUCCESS);
    // complainList.length--;
    update();
    // Get.off("/mycomplains");
    return response;
  }
}
