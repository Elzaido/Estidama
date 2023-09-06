import 'package:flutter/cupertino.dart';
import '../ui/pages/main_pages/complains.dart';
import '../ui/pages/main_pages/recycling.dart';
import '../ui/pages/main_pages/tree.dart';
import '../ui/pages/main_pages/volunteering.dart';

class GridModel {
  String? title;
  String? image;
  Widget? nav;
  GridModel({required this.title, required this.image, required this.nav});
}

List<GridModel> gridList = [
  GridModel(title: 'تقديم بلاغ', image: 'assets/Grid1.png', nav: Complains()),
  GridModel(
      title: 'التطوع', image: 'assets/Grid2.png', nav: const Volunteering()),
  GridModel(
      title: 'إزرع شجرة', image: 'assets/Grid3.png', nav: const TreePlanting()),
  GridModel(
      title: 'إعادة التدوير',
      image: 'assets/Grid4.png',
      nav: const Recycling()),
];
