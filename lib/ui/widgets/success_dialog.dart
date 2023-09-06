import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs {
  Color green_c = const Color.fromARGB(255, 141, 203, 141);
//this will bes used on success events
  late Size size;
  void success_dialog(String success_msg, BuildContext context,
      String description, String img_link) {
    // final HomeController _controller = Get.find();
    size = MediaQuery.of(context).size;

    Get.defaultDialog(
        titlePadding: const EdgeInsets.all(30),
        // textCustom: "",custom: Icon(Icons.alarm),
        // title: "helllllllllllllll",
        // textCancel: "",
        backgroundColor: Colors.transparent,
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(begin: Alignment.topLeft, colors: [
                Color.fromRGBO(64, 18, 139, 1),
                Color.fromRGBO(147, 54, 180, 1)
              ])),
          width: size.width * 0.7,
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              Image.asset(
                img_link,
                width: size.width * 0.35,
                height: size.height * 0.22,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                width: size.width * 0.5,
                child: Text(
                  success_msg,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.45,
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: green_c,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              )

              ///
            ],
          )),
        )).then((value) => 2);
  }
}
