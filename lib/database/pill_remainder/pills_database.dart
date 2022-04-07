

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PillRemainderDatabase{
  setDatabase() async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath,"pill_remainder");
    Database database = await openDatabase(path,version: 1,onCreate: (Database db,int version)async{
      await db.execute("CREATE TABLE PillRemainder (id INTEGER PRIMARY KEY, name TEXT, amount TEXT, type TEXT, howManyWeeks INTEGER, medicineForm TEXT, time INTEGER, notifyId INTEGER)");
    });
    return database;
  }
}