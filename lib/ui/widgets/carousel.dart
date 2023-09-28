import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/home_controller.dart';
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
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                )),
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
  return CarouselSlider(
    items: items, // Use the list of CarouselSlider items
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
}

Widget imageWidgetForAchievemnts(size) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
// <<<<<<< zamel
//     child: Stack(
//       children: [
//         Column(
//           children: [
//             Center(
//               child: Image(
//                 image: const AssetImage("assets/noInternet.png"),
//                 fit: BoxFit.fill,
//                 width: double.infinity, // Match the width of the Container
//                 height: size.height * 0.29, // Match the height of the Container
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     offset: const Offset(10, 9),
//                     color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
//                     spreadRadius: 4,
//                     blurRadius: 6,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         )
//       ],
// =======
    child: SizedBox(
      width: double.infinity, // Match the width of the Container
      height: size.height * 0.29, // Match the height of the Container
      child: loading(),
// >>>>>>> master
    ),
  ).paddingOnly(top: 10);
}
