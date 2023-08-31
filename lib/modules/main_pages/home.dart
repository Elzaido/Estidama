import 'package:flutter/material.dart';

import '../../models/gridmodel.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 1,
        crossAxisSpacing: 2,
        childAspectRatio: 1 / 1.3,
        // list.generation(Length, itemBuilder// anonemus function that return the item).
        children: GridList.map((GridItem) {
          return InkWell(
            onTap: () {},
            child: Card(
              elevation: 10,
              margin: const EdgeInsets.all(8),
              child: Container(
                color: Colors.green[100],
                child: Column(
                  children: [
                    Image.asset('${GridItem.image}'),
                    Text(
                      '${GridItem.name}',
                      style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
