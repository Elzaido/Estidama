import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/home_controller.dart';
import 'package:madenati/models/achievements_model.dart';
import 'package:madenati/ui/widgets/carousel.dart';
import '../../../models/gridmodel.dart';
import '../../widgets/interface_components.dart';
import '../../widgets/grid_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<AchievementModel> achievementsList = [];
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<Widget> carousel_data = [];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:
            defaultAppBar(context: context, title: 'الرئيسية', isHome: true),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                carousel(
                    items: carousel_data,
                    homeController: homeController,
                    size: size),
                const SizedBox(
                  height: 5,
                ),
                separator(),
                const SizedBox(
                  height: 5,
                ),
                useActionGridView(context).paddingAll(2)
              ],
            ),
          ),
        ));
  }

  Widget useActionGridView(context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1 / 1.10,
      children: gridList.map((item) {
        return gridItem(
            context: context,
            nav: item.nav!,
            image: item.image!,
            title: item.title!);
      }).toList(),
    );
  }
}
