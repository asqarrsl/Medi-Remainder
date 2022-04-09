import 'package:medi_remainder/database/pill_remainder/pillRemainder_database.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
   
  PillRemainderDatabase _pillRemainderDatabase = PillRemainderDatabase();
  static Database? _db;

  //initialization of database
  Future<Database> get database_init async {
    if (_db != null) return _db!;
    //creating the database
    _db = await _pillRemainderDatabase.createDatabase();
    return _db!;
  }

  //Insertion to database
  Future<int?> insert(String table, Map<String, dynamic> data) async {
    Database database = await database_init;
    try {
      return await database.insert(table, data);
    } catch (e) {
      return null;
    }
  }

  //fetch all data from database
  Future<List<Map<String, dynamic>>?> fetchAllData(table) async {
    Database database = await database_init;
    try {
      return database.query(table);
    } catch (e) {
      return null;
    }
  }

  //delete data from database
  Future<int?> delete(String table, int id) async {
    Database database = await database_init;
    try {
      return await database.delete(table, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      return null;
    }
  }
}
