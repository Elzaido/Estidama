// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/component.dart';
import '../shared/constant.dart';
import '../shared/cubit/homecubit.dart';
import '../shared/cubit/homestate.dart';

class HomeLayout extends StatelessWidget {
  final PageStorageBucket bucket = PageStorageBucket();

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: ((context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: cubit.titles[cubit.currentIndex],
              isHome: true),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton:
          FloatingActionButton(
            backgroundColor: HomeCubit.get(context).currentIndex == 1 ? mainColor: Colors.white,
            onPressed: () {
              HomeCubit.get(context).currentIndex = 1;
              HomeCubit.get(context)
                  .changeNav(HomeCubit.get(context).currentIndex);
            },
            child: Icon(Icons.home_filled, color: HomeCubit.get(context).currentIndex == 1 ? Colors.white: mainColor),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 10,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          HomeCubit.get(context).currentIndex = 0;
                          HomeCubit.get(context)
                              .changeNav(HomeCubit.get(context).currentIndex);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: HomeCubit.get(context).currentIndex == 0
                                  ? mainColor
                                  : Colors.grey,
                            ),
                            Text(
                              'الملف الشخصي',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: HomeCubit.get(context).currentIndex == 0
                                    ? mainColor
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          HomeCubit.get(context).currentIndex = 2;
                          HomeCubit.get(context)
                              .changeNav(HomeCubit.get(context).currentIndex);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              color: HomeCubit.get(context).currentIndex == 2
                                  ? mainColor
                                  : Colors.grey,
                            ),
                            Text(
                              'بلاغاتي',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: HomeCubit.get(context).currentIndex == 2
                                    ? mainColor
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
