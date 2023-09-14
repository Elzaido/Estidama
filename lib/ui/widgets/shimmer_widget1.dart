import 'package:flutter/material.dart';
import 'package:madenati/ui/widgets/separator_widget.dart';
import 'package:shimmer/shimmer.dart';

Widget homeShimmerWidget({required Size size}) => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.separated(
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => separator(),
              itemCount: 5)),
    );
