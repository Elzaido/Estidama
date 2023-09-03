import 'package:get/get.dart';

class ComplainsController extends GetxController {
  String selectedComplain = 'دخان المصانع';
  bool isDropdownOpen = false;
  List<String> complainsList = [
    'دخان المصانع',
    'نقص في حاويات القمامة',
    'كلاب ضالة',
    'قطع أشجار الغابات',
  ];
  String selectedStatus = 'قليلة الخطورة';
  List<String> complainStatus = [
    'قليلة الخطورة',
    'متوسطة الخطورة',
    'عالية الخطورة'
  ];

  void toggleDropdown() {
    isDropdownOpen = !isDropdownOpen;
  }
}
