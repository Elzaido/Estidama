import 'package:flutter/material.dart';
import '../../../models/gridmodel.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/grid_widget.dart';

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
            child: GridView.count(
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
          ),
        ));
  }
}
