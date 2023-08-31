// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madenati/modules/main_pages/my_posts.dart';
import 'package:madenati/modules/main_pages/profile.dart';
import '../../modules/main_pages/home.dart';
import 'homestate.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<dynamic> photos = [];
  List<dynamic> search = [];
  int currentIndex = 0;

  List<Widget> screens = [
    const Home(),
    const Profile(),
    const MyPost(),
  ];

  List<String> titles = [

    'الملف الشخصي',
    'الرئيسية',
    'بلاغاتي',
  ];

  void changeNav(int index) {
      currentIndex = index;
      emit(ChangeNavState());
    }
  }

