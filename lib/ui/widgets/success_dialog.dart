import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs {
  Color greenC = const Color.fromARGB(255, 141, 203, 141);
  late Size size;
  void successDialog(String successMsg, BuildContext context,
      String description, String imgLink) {
    size = MediaQuery.of(context).size;

    Get.defaultDialog(
        titlePadding: const EdgeInsets.all(30),
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
                imgLink,
                width: size.width * 0.35,
                height: size.height * 0.22,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                width: size.width * 0.5,
                child: Text(
                  successMsg,
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
                    color: greenC,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          )),
        )).then((value) => 2);
  }
}
