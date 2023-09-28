import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/hotlinks.dart';
import 'package:madenati/controllers/home_controller.dart';
import 'package:madenati/models/achievements_model.dart';
import 'package:madenati/ui/widgets/interface_components.dart';
import '../../constants/colors.dart';

Widget carsoulItem(
        {required String image,
        required String title,
        required String text,
        required Size size}) =>
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: size.height * 0.3,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            SizedBox(
              width: double
                  .infinity, // This makes the container take the full width
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: const AssetImage("assets/loading.gif"),
                image: NetworkImage(image),
              ),
            ),
            Container(
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withOpacity(0.8),
                      spreadRadius: 6,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Cairo',
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                      ),
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Cairo',
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  ).paddingAll(10),
                )),
          ],
        ),
      ),
    );

// If you want to add a carsoul item add it here and it will appear in the UI.
Widget carousel(
    {required List<Widget> items,
    required HomeController homeController,
    required Size size}) {
  return FutureBuilder(
      future: homeController.getAchievementsData(),
      builder: (context, AsyncSnapshot snapshot) {
        try {
          if (snapshot.connectionState == ConnectionState.waiting) {
            loading();
          }
          List<Widget> carouselItems =
              []; // Create a list to store CarouselSlider items

          for (int index = 0; index < snapshot.data['data'].length; index++) {
            AchievementModel model =
                AchievementModel.fromJson(snapshot.data['data'][index]);
            carouselItems.add(
              carsoulItem(
                size: size,
                image: "$complainImages/${model.achievementImg}",
                title: model.achievementTitle.toString(),
                text: model.achievementDescription.toString(),
              ),
            );
          }

          return CarouselSlider(
            items: carouselItems, // Use the list of CarouselSlider items
            options: CarouselOptions(
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 15),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          );
        } catch (e) {
          print(e);
        }
        return ImageWidgetForAchievemnts(size);
      });
}

Widget ImageWidgetForAchievemnts(size) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Stack(
      children: [
        Column(
          children: [
            Center(
              child: Image(
                image: const AssetImage("assets/nointernet.png"),
                fit: BoxFit.fill,
                width: double.infinity, // Match the width of the Container
                height: size.height * 0.29, // Match the height of the Container
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(10, 9),
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                    spreadRadius: 4,
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  ).paddingOnly(top: 10);
}
