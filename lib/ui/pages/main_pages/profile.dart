// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/profile_controller.dart';
import 'package:madenati/db/local/shared_preference.dart';
import '../../widgets/interface_components.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  ProfileController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find();
    return Scaffold(
      appBar:
          defaultAppBar(context: context, title: 'الملف الشخصي', isHome: true),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 140,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.2s7VxdmHEoDKji3gO_i-5QHaHa?pid=ImgDet&rs=1'),
                radius: 50,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                CacheHelper.getData(key: "user_name").toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.verified,
                color: Colors.blue,
                size: 20,
              )
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(16.0), // Adjust the radius as needed
                color: const Color.fromARGB(255, 247, 247, 247),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4), // Shadow color
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(
                        0, 2), // Shadow position [horizontal, vertical]
                  ),
                ],
              ),
              child: Column(
                children: [
                  profileButton(
                      onPressed: () {},
                      icon: const Icon(Icons.numbers_outlined),
                      text: CacheHelper.getData(key: "user_number")),
                  separator(),
                  profileButton(
                      onPressed: () {},
                      text: profileController.iterateUserProvince(int.parse(CacheHelper.getData(key: "user_province"))).toString(),
                      icon: const Icon(Icons.location_city)),
                  separator(),
                  profileButton(
                      onPressed: () {},
                      text: CacheHelper.getData(key: "user_join_date"),
                      icon: const Icon(Icons.date_range)),
                  separator(),
                  profileButton(
                      onPressed: () {},
                      text: CacheHelper.getData(key: "user_gender") == 'male'
                          ? "ذكر"
                          : 'انثى',
                      icon: CacheHelper.getData(key: "user_gender") == 'male'
                          ? const Icon(Icons.male)
                          : const Icon(Icons.female)),
                  separator(),
                  profileButton(
                      onPressed: () => controller.signOutActions(),
                      text: 'تسجيل الخروج',
                      icon: const Icon(Icons.logout)),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget profileButton(
      {required void Function()? onPressed,
      required String text,
      required Icon icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: TextButton(
                onPressed: onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    icon,
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
