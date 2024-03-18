import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:persona/model/database_instance.dart';

class Rows{
  String id_event;
  String isClick;

  Rows({
    required this.id_event,
    required this.isClick,
  });
}


class Notify {
  final dbHelper = DatabaseHelper();

  void initState() async {
    await dbHelper.db; // Inisialisasi database saat initState dipanggil
  }

  final result =  List<Rows>  ;


}
