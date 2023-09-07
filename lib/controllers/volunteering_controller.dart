import 'package:get/get.dart';

class VolunteeringController extends GetxController {
  bool isDropdownOpen = false;
  List<String> volunteringTypeList = [
    'زراعة',
    'نظافة',
  ];
  RxString selectedVolunteringType = 'زراعة'.obs;

  int fromTextToIntComplain() {
    int volunteringTypeNumber = 0;
    switch (selectedVolunteringType.value) {
      case 'زراعة':
        volunteringTypeNumber = 1;
        break;
      case 'نظافة':
        volunteringTypeNumber = 2;
        break;
    }
    return volunteringTypeNumber;
  }

  switchSelectedVolunteringType(newValue) =>
      selectedVolunteringType.value = newValue;
  toggleDropdown() => isDropdownOpen = !isDropdownOpen;
}
