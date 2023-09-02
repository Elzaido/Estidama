// ignore_for_file: camel_case_types

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madenati/shared/cubit/homecubit.dart';
import '../shared/constant.dart';
import 'Layout/home_layout.dart';
import 'modules/authentication/login.dart';
import 'modules/on_boarding.dart';
import 'network/local/shared_preference.dart';
//new comment here by zameel
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');
  Widget widget;
  if (onBoarding != null) {
    if (uId != null) {
      widget = HomeLayout();
    } else {
      widget = LoginPage();
    }
  } else {
    widget = const OnBoarding();
  }
  runApp(myApp(
    startWidget: widget,
  ));
}

class myApp extends StatelessWidget {
  const myApp({super.key, required this.startWidget});

  final Widget startWidget;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context) {
      return HomeCubit();
    },
    child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AnimatedSplashScreen(
              splashIconSize: 180,
              duration: 4000,
              splash: const Image(
                image: AssetImage('assets/logo1.png'),
              ),
              nextScreen: startWidget,
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: const Color(0xFFC3F5C6)),
        ));
  }
}
