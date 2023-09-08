import 'package:get/get.dart';

class VolunteeringController extends GetxController {
  bool isDropdownOpen = false;
  List<String> volunteringTypeList = [
    'زراعة',
    'نظافة',
  ];
  List<String> volunteringGroupList = [
    'مدرسة',
    'أهل حي',
    'جمعية خيرية',
  ];

  RxString selectedVolunteringGroup = 'مدرسة'.obs;
  RxString selectedVolunteringType = 'زراعة'.obs;

  switchSelectedVolunteringType(newValue) =>
      selectedVolunteringType.value = newValue;
  switchSelectedVolunteringGroup(newValue) =>
      selectedVolunteringGroup.value = newValue;
}
