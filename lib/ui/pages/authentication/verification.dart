import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/ui/widgets/interface_components.dart';
import 'package:pinput/pinput.dart';

class Verification extends StatelessWidget {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/auth.png',
                width: 180,
                height: 180,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "التحقق من الهاتف",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo'),
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                onChanged: (value) {
                  code = value;
                },
                showCursor: true,
                onCompleted: (pin) => log(pin),
              ),
              const SizedBox(
                height: 20,
              ),
              button(
                  onPressed: () {
                    if (code == '123456') {
                      Get.toNamed('/launcher');
                    }
                  },
                  child: const Text(
                    'تحقق من رقم الهاتف',
                    style: TextStyle(fontFamily: 'Cairo'),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                      child: const Text(
                        "تغيير رقم الهاتف؟",
                        style: TextStyle(fontFamily: 'Cairo'),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
