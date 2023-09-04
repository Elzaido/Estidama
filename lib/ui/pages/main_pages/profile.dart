// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/profile_button_widget.dart';
import '../../widgets/separator_widget.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Zaid Raed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
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
                      icon: const Icon(Icons.edit),
                      text: 'تعديل الملف الشخصي'),
                  separator(),
                  profileButton(
                      onPressed: () {},
                      text: 'تقديم بلاغ',
                      icon: const Icon(Icons.add)),
                  separator(),
                  profileButton(
                      onPressed: () {},
                      text: 'بلاغاتي',
                      icon: const Icon(Icons.ad_units)),
                  separator(),
                  profileButton(
                      onPressed: () {},
                      text: 'التقديم للعمل التطوعي',
                      icon: const Icon(Icons.favorite_border)),
                  separator(),
                  profileButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
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
}
