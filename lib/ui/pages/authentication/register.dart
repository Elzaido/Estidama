// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/constants/colors.dart';
import 'package:madenati/controllers/register_controller.dart';
import 'package:madenati/ui/widgets/button_widget.dart';
import 'package:madenati/ui/widgets/dropdown_widget.dart';
import '../../widgets/formfield_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  static String verify = "";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var phone = "";
  var formKey = GlobalKey<FormState>();
  final nameControl = TextEditingController();
  final phoneControl = TextEditingController();
  final countryControl = TextEditingController();
  final passwordControl = TextEditingController();

  bool isPass1 = true;
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  void selectMale() {
    setState(() {
      isMaleSelected = true;
      isFemaleSelected = false;
    });
  }

  void selectFemale() {
    setState(() {
      isMaleSelected = false;
      isFemaleSelected = true;
    });
  }

  @override
  void initState() {
    countryControl.text = "+962";
    super.initState();
  }

  @override
  void dispose() {
    //ITS A GOOD PRACTICE TO DISPOSE THESSE OBJECTS FROM MEMORY TO AVOID MEMORY FULLNESS
    nameControl.dispose();
    countryControl.dispose();
    phoneControl.dispose();
    passwordControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RegisterController registerController = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.toNamed('/login');
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "إنشاء حساب",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  formField(
                      control: nameControl,
                      isScure: false,
                      label: 'الإسم',
                      prefIcon: const Icon(Icons.person_outline),
                      validator: (String? value) {
                        if (value!.length < 8) {
                          return "يجب ان يكون الاسم 8 احرف او اكثر";
                        }
                        if (value.isEmpty) {
                          return 'يجب إدخال الإسم';
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isMaleSelected ? null : selectMale,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.green;
                                }
                                return isMaleSelected
                                    ? mainColor
                                    : const Color.fromARGB(255, 197, 197, 197);
                              },
                            ),
                          ),
                          child: const Text('ذكر',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Cairo')),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isFemaleSelected ? null : selectFemale,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.green;
                                }
                                return isFemaleSelected
                                    ? mainColor
                                    : const Color.fromARGB(255, 197, 197, 197);
                              },
                            ),
                          ),
                          child: const Text('أنثى',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Cairo')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          enabled: false,
                          controller: countryControl,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 4,
                          child: TextFormField(
                            controller: phoneControl,
                            onChanged: (value) {
                              phone = value;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              isDense: true,
                              hintTextDirection: TextDirection.rtl,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "  رقم الهاتف",
                              hintStyle: const TextStyle(fontFamily: 'Cairo'),
                            ),
                            validator: (value) {
                              if (value!.length != 9) {
                                return "يجب ان يتكون رقم الهاتف من 9 خانات ";
                              } else if (value.isEmpty) {
                                return 'يجب إدخال رقم الهاتف';
                              } else {
                                return null;
                              }
                            },
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => dropDown(
                        selected: registerController.selectedProvince.value,
                        list: registerController.provinces,
                        FLAG: 1),
                    //flag IS ONLY 1 WHEN ITS DROP DOWN FOR THE PROVINCES JUST BRCAUSE IT HAS SPECIAL SETTING IN ITS FUCTION
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(() => formField(
                      control: passwordControl,
                      isScure: registerController.isScure.value,
                      label: 'كلمة السر',
                      prefIcon: const Icon(Icons.lock),
                      suffButton: IconButton(
                          onPressed: () {
                            registerController.changeIsScure();
                          },
                          icon: registerController.isScure.value
                              ? const Icon(Icons.remove_red_eye)
                              : const Icon(Icons.visibility_off)),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'يجب إدخال كلمة السر';
                        } else if (value.toString().length < 8) {
                          return "يجب ان تكون كلمة المرور 8 خانات او اكثر";
                        }
                        return null;
                      })),

                  const SizedBox(
                    height: 20,
                  ),
                  // dropDown(selected: registerController.selectedProvince, list: registerController.provinces,  ),
                  button(
                      onPressed: () => formKey.currentState!.validate()
                          ? registerController.signUpProcess(
                              nameControl.text,
                              phoneControl.text,
                              registerController.selectedProvince
                                  .value, //put the province data here  as number or id begin from 1: irbid
                              isMaleSelected == true ? "male" : "female",
                              passwordControl.text,
                            )
                          : null,
                      child: const Text(
                        "إنشاء حساب",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.toNamed('/login');
                            // Navigator.pop(context);
                          },
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          )),
                      const Text(
                        'لديك حساب؟',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
