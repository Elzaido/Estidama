import 'package:get/get.dart';
import 'package:madenati/db/remote/sql.dart';
import '../constants/hotlinks.dart';

class HomeController extends GetxController {
  getAchievementsData() async {
    var response;

    try {
      response = await postRequest(retriveAchievementsLink, {});
      if (response['status'] == 'scucess') {
        print("workkkks");
      }

      if (response['status'] == 'faild') {}
    } catch (e) {
      print(e.hashCode);
    }
    return response;
  }
}
