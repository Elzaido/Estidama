import 'package:flutter/cupertino.dart';

class GridModel {
  String? name;
  String? image;
  Widget? nav;
  GridModel({required this.name, required this.image, required this.nav});
}

List<GridModel> GridList = [
  GridModel(
      name: 'تقديم بلاغ',
      image: 'assets/Grid1.png'),
  GridModel(
      name: 'التطوع',
      image: 'assest/Grid2.png'),
  GridModel(
      name: 'إزرع شجرة',
      image: 'assets/Grid3.png'),
  GridModel(
      name: 'إعادة التدوير',
      image: 'assets/Grid4.png'),
];
