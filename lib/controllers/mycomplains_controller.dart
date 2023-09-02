import 'dart:developer';

import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../ui/widgets/toast_widget.dart';

class MyComplainsController extends GetxController {
  late Database database;
  List<Map> myComplainsList = [];

// Sqflite functions:

  createDB() {
    openDatabase('compalins.db', version: 1, onCreate: (database, version) {
      log('DB Created');
      database
          .execute(
              'CREATE TABLE MyCompalins (id INTEGER PRIMARY KEY, image TEXT, title TEXT, desc TEXT)')
          .then((value) {
        log('Table created');
      }).catchError((error) {
        log('error when creating table ${error.toString()}');
      });
    }, onOpen: (database) {
      log('DB Opened');

      getFromDB(database);
    }).then((value) {
      database = value;
      throw ('DB Created');
    });
  }

  insertToDB(
      {required String image, required String title, required String desc}) {
    database.transaction((txn) {
      return txn.rawInsert(
          'insert into MyCompalins (image ,title, desc) VALUES("$image","$title","$desc")');
    }).then((value) {
      log('$value inserted sucssesfully');
      defaultToast(
          massage: 'تم إرسال البلاغ بنجاح', state: ToastStates.SUCCESS);
      getFromDB(database);
    }).catchError((error) {
      log('error when inserting data ${error.toString()}');
    });
  }

  void getFromDB(database) {
    myComplainsList = [];

    database.rawQuery('SELECT * FROM Tasks').then((value) {
      value.forEach((elements) {
        myComplainsList.add(elements);
        log('$myComplainsList');
      });
    }).catchError((error) {
      log('$error');
    });
  }

  void deleteFromDB({required int id}) async {
    database
        .rawDelete('DELETE FROM MyCompalins WHERE id = ?', [id]).then((value) {
      defaultToast(massage: 'تم إلغاء البلاغ', state: ToastStates.ERROR);
      getFromDB(database);
    });
  }
}
