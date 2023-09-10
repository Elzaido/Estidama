import 'package:flutter/material.dart';
import 'package:madenati/constants/carsousel_items.dart';
import 'package:madenati/ui/widgets/carousel_slider_widget.dart';
import 'package:madenati/ui/widgets/home_shimmer_widget.dart';
import '../../../models/gridmodel.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/grid_widget.dart';
import '../../widgets/separator_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool isLoading;

  @override
  void initState() {
    isLoading = true;
    Future.delayed(const Duration(seconds: 7), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:
            defaultAppBar(context: context, title: 'الرئيسية', isHome: true),
        body: isLoading
            ? SingleChildScrollView(child: shimmerWidget(size: size))
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
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
                      useActionGridView(context)
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
