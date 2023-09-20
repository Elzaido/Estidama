import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapScreenController extends GetxController {
  void openPopUp(context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('فعل خدمات تحديد الموقع'),
            content: const Text('يرجى تمكين خدمات الموقع على هاتفك.'),
            actions: <Widget>[
              TextButton(
                child: const Text('حسناً'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
