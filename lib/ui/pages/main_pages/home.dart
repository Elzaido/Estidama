import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/home_controller.dart';
import 'package:madenati/models/achievements_model.dart';
import '../../widgets/carousel.dart';
import '../../../constants/hotlinks.dart';
import '../../../models/gridmodel.dart';
import '../../widgets/interface_components.dart';
import '../../widgets/grid_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:
            defaultAppBar(context: context, title: 'الرئيسية', isHome: true),
        body: SizedBox(
            width: size.width,
            height: size.height,
            child: FutureBuilder(
                future: homeController.getAchievementsData(),
                builder: (context, AsyncSnapshot snapshot) {
                  try {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      homeShimmerWidget(size: size);
                    }

                    List<Widget> carouselItems =
                        []; // Create a list to store CarouselSlider items

                    for (int index = 0;
                        index < snapshot.data['data'].length;
                        index++) {
                      AchievementModel model = AchievementModel.fromJson(
                          snapshot.data['data'][index]);
                      carouselItems.add(
                        carsoulItem(
                          size: size,
                          image: "$complainImages/${model.achievementImg}",
                          title: model.achievementTitle.toString(),
                          text: model.achievementDescription.toString(),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            carousel(
                                items: carouselItems,
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
                    );
                  } catch (error) {
                    print(error);
                  }
                  return homeShimmerWidget(size: size);
                })));
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
