import 'package:flutter/material.dart';

Widget gridItem({
  required context,
  required Widget nav,
  required String image,
  required String title,
}) {
  return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => nav));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(16.0), // Adjust the radius as needed
          color: const Color.fromARGB(255, 247, 247, 247),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8), // Shadow color
              spreadRadius: 3,
              blurRadius: 7,
              offset:
                  const Offset(-1, 2), // Shadow position [horizontal, vertical]
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(16.0), // Adjust the radius as needed
              color: const Color.fromARGB(255, 247, 247, 247),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(
                      0, 2), // Shadow position [horizontal, vertical]
                ),
              ],
            ),
            child: Stack(
              children: [
                Image(
                  image: AssetImage(image),
                  fit: BoxFit.fill,
                ),
                Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 6,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ));
}
