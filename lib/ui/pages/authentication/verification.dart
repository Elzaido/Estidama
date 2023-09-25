import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/register_controller.dart';
import 'package:madenati/ui/widgets/interface_components.dart';
import 'package:pinput/pinput.dart';

//THIS CODE FEATURE WAS MADE BY EL ZAIDO
// AND DEVELOPED AND MAINTAINED BY ZAMEL STUDIOS
class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _NameState();
}

class _NameState extends State<Verification> {
  final pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    pinController.setText('1971');
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        Get.arguments as Map<String, dynamic>;
    final String name = arguments['name'];
    final String phone = arguments['phone'];
    final String password = arguments['password'];
    String code = "";
    RegisterController registerController = Get.find();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            elevation: 0,
          ),
          body: Obx(
            () => Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        verificationBody(code, size),
                        submitButton(
                            code, registerController, name, phone, password),
                        changePhoneTextBtn()
                      ],
                    ),
                  ),
                ),
                if (registerController.isLoading.value) loading(),
              ],
            ),
          )),
    );
  }

  Widget verificationBody(code, size) {
    return Column(
      children: [
        Image.asset(
          'assets/auth.png',
          width: size.width * 0.4,
          height: size.height * 0.25,
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
          "التحقق من الهاتف",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
        ),
        const SizedBox(
          height: 30,
        ),
        Pinput(
          controller: pinController,
          length: 4,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
          onChanged: (value) {
            code = value;
          },
          showCursor: true,
          onCompleted: (pin) => log(pin),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget changePhoneTextBtn() {
    return Row(
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
    );
  }

  Widget submitButton(code, registerController, name, phone, password) {
    return button(
        onPressed: () {
          code = "1971";
          if (code == '1971') {
            // Perform the signup function here with the provided arguments
            loading();
            registerController.signUpProcess(
              name,
              phone,
              registerController.selectedProvince.value,
              registerController.isMaleSelected.value == true
                  ? "male"
                  : "female",
              password,
            );
          } else {}
        },
        child: const Text(
          'تحقق من رقم الهاتف',
          style: TextStyle(fontFamily: 'Cairo'),
        ));
  }
}
