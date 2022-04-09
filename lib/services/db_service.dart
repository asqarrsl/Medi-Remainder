//import 'package:flutter/material.dart';
import 'package:medi_remainder/models/health.dart';
import 'package:medi_remainder/utils/db_helper.dart';

class DBservice {
  Future<List<HealthModel>> getHealth() async {
    await DBHelper.init();

    List<Map<String, dynamic>> health = await DBHelper.query(HealthModel.table);

    return health.map((item) => HealthModel.fromMap(item)).toList();
  }

  Future<bool> addHealth(HealthModel model) async {
    await DBHelper.init();

    int ret = await DBHelper.insert(HealthModel.table, model);

    return ret > 0 ? true : false;
  }

    Future<bool> updateHealth(HealthModel model) async {
    await DBHelper.init();

    int ret = await DBHelper.update(HealthModel.table, model);

    return ret > 0 ? true : false;
  }
  
    Future<bool> deleteHealth(HealthModel model) async {
    await DBHelper.init();

    int ret = await DBHelper.delete(HealthModel.table, model);

    return ret > 0 ? true : false;
  }

}
