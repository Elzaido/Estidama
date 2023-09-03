import 'package:flutter/material.dart';
import 'package:madenati/ui/pages/main_pages/luncher.dart';
import 'package:madenati/ui/widgets/button_widget.dart';
import '../../widgets/formfield_widget.dart';
import '../../widgets/toast_widget.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  var phone = "";
  final phoneControl = TextEditingController();
  final countryControl = TextEditingController();
  final passControl = TextEditingController();

  @override
  void initState() {
    countryControl.text = "+962";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/login.png',
                          width: 180,
                          height: 180,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "أدخل رقم هاتفك و كلمة السر لإتمام عملية تسجبل الدخول",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Cairo'),
                        ),
                        const SizedBox(
                          height: 30,
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
                        const SizedBox(
                          height: 20,
                        ),
                        formField(
                            control: passControl,
                            isScure: true,
                            label: 'كلمة السر',
                            prefIcon: const Icon(Icons.lock),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'يجب إدخال كلمة السر';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        button(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (phoneControl.text == '780710751') {
                                  defaultToast(
                                      massage: 'تم تسجيل الدخول بنجاح',
                                      state: ToastStates.SUCCESS);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Luncher()),
                                      (Route<dynamic> route) => false);
                                } else {
                                  defaultToast(
                                      massage: 'الرجاء إنشاء الحساب أولاً',
                                      state: ToastStates.ERROR);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                }
                              }
                            },
                            child: const Text(
                              "تسجيل دخول",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      // from where :
                                      context,
                                      // where to send :
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                },
                                child: const Text(
                                  'إنشاء حساب',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                )),
                            const Text(
                              'ليس لديك حساب؟',
                              style: TextStyle(fontFamily: 'Cairo'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )))),
    );
  }
}
