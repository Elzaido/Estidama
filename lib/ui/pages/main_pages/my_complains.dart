import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madenati/controllers/mycomplains_controller.dart';
import 'package:madenati/ui/widgets/separator_widget.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/mycomplain_widget.dart';

class MyComplains extends StatelessWidget {
  const MyComplains({super.key});

  @override
  Widget build(BuildContext context) {
    MyComplainsController controller = Get.find();
    return Scaffold(
        appBar: defaultAppBar(context: context, title: 'بلاغاتي', isHome: true),
        body: controller.myComplainsList.isNotEmpty
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView.separated(
                  itemBuilder: (context, index) => myComplainItem(
                      context, controller.myComplainsList[index]),
                  itemCount: controller.myComplainsList.length,
                  separatorBuilder: (context, index) => separator(),
                ),
              )
            : const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لم تقم بتقديم أي بلاغ حتى الآن',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 30,
                    )
                  ],
                ),
              ));
  }
}
