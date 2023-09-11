class GridModel {
  String? title;
  String? image;
  String? nav;
  GridModel({required this.title, required this.image, required this.nav});
}

List<GridModel> gridList = [
  GridModel(title: 'تقديم شكوى', image: 'assets/Grid1.png', nav: '/complains'),
  GridModel(title: 'التطوع', image: 'assets/Grid2.png', nav: '/volunteering'),
  GridModel(
      title: 'إزرع شجرة', image: 'assets/Grid3.png', nav: '/volunteering'),
  GridModel(
      title: 'إعادة التدوير', image: 'assets/Grid4.png', nav: '/recycling'),
  GridModel(
      title: 'نبذة عن التطبيق', image: 'assets/logo1.gif', nav: '/aboutapp'),
];
