import 'package:get/get.dart';
import 'package:madenati/db/local/shared_preference.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';

onSuccessfulUserAuth(response, String toastMessage) async {
  defaultToast(massage: toastMessage, state: ToastStates.SUCCESS);

  CacheHelper.saveData(
      key: "user_name", value: response['data']['user_name'].toString());

  CacheHelper.saveData(
      key: "user_number", value: response['data']['user_number'].toString());

  CacheHelper.saveData(
      key: "user_province",
      value: response['data']['user_province'].toString());

  CacheHelper.saveData(
      key: "user_join_date",
      value: response['data']['user_join_date'].toString());

  CacheHelper.saveData(
      key: "user_gender", value: response['data']['user_gender'].toString());
  CacheHelper.saveData(
      key: "user_id", value: response['data']['user_id'].toString());

  CacheHelper.saveData(key: "isLogin", value: true);

  Get.offAllNamed("/launcher");
}
