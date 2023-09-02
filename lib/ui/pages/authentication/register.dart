// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../widgets/formfield_widget.dart';
import '../../widgets/toast_widget.dart';
import 'login.dart';

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

  final emailControl = TextEditingController();

  bool isPass1 = true;

  @override
  void initState() {
    countryControl.text = "+962";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                  SizedBox(
                    height: 20,
                  ),
                  formField(
                      control: nameControl,
                      isScure: false,
                      label: 'الإسم',
                      prefIcon: Icon(Icons.person_outline),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'يجب إدخال الإسم';
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  formField(
                      control: emailControl,
                      isScure: false,
                      label: 'الريد الإلكتروني',
                      prefIcon: Icon(Icons.email),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'يجب إدخال البريد الإلكتروني';
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: countryControl,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        ),
                      ),
                      SizedBox(
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
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'يجب إدخال رقم الهاتف';
                              } else {
                                return null;
                              }
                            },
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (nameControl.text == 'zaid') {
                              defaultToast(
                                  massage: 'الحساب موجود بالفعل!',
                                  state: ToastStates.ERROR);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            } else {
                              defaultToast(
                                  massage: 'تم إنشاء الحساب بنجاح!',
                                  state: ToastStates.SUCCESS);
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeLayout()));
                            }
                          }
                        },
                        child: Text(
                          "إنشاء حساب",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                          ),
                        )
                        // : Center(
                        // child: CircularProgressIndicator(
                        //   backgroundColor: Colors.white,
                        //   color: mainColor,
                        //   strokeWidth: 3,
                        // ))
                        ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          )),
                      Text(
                        'لديك حساب؟',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(
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
