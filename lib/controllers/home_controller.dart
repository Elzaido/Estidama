import 'package:get/get.dart';
import 'package:madenati/db/remote/sql.dart';
import 'package:madenati/ui/widgets/toast_widget.dart';

import '../constants/hotlinks.dart';

class HomeController extends GetxController {
  getAchievementsData() async {
    var response;

    try {
      response = await postRequest(retriveAchievementsLink, {});
      if (response['status'] == 'scucess') {
        print("workkkks");
      }

      if (response['status'] == 'faild') {
        // defaultToast(massage: "فشل ", state: state)
      }
    } catch (e) {
      print(e.hashCode);
    }
    return response;
  }
  
}
