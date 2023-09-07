import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget carousel({required List<Widget> items, required Size size}) =>
    CarouselSlider(
        items: items,
        options: CarouselOptions(
          height: size.height * 0.31,
          initialPage: 0,
          viewportFraction: 1.0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ));
