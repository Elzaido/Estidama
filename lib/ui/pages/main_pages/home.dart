import 'package:flutter/material.dart';
import 'package:madenati/constants/carsousel_items.dart';
import 'package:madenati/ui/widgets/carousel_slider_widget.dart';
import '../../../models/gridmodel.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/grid_widget.dart';
import '../../widgets/separator_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            defaultAppBar(context: context, title: 'الرئيسية', isHome: true),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                carousel(items: images),
                const SizedBox(
                  height: 10,
                ),
                separator(),
                const SizedBox(
                  height: 10,
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1 / 1.30,
                  children: gridList.map((item) {
                    return gridItem(
                        context: context,
                        nav: item.nav!,
                        image: item.image!,
                        title: item.title!);
                  }).toList(),
                ),
              ],
            ),
          ),
        ));
  }
}
