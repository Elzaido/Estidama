import 'package:flutter/material.dart';
import 'package:madenati/ui/widgets/separator_widget.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerWidget({required Size size}) => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: size.height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            separator(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
