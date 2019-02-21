import 'dart:io';
import 'package:shopping_list/model/nodo_item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  final String tableName = "nodotbl";
  final String columnId = "id";
  final String columnItemname = "itemName";
  //final String columnEmail = "email";
  final String columnDateCreated = "dateCreated";
  static Database _db;

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  DatabaseHelper.internal();
  initDb() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "shopping_list_maker_db.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableName("
            "$columnId INTEGER PRIMARY KEY,"
            "$columnItemname TEXT,"
            "$columnDateCreated TEXT)"
    );
  }
  // CRUD => CREATE, READ or SELECT, UPDATE, DELETE.

  Future<int> saveItem(NoDoItem item) async{
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", item.toMap());
    return res;
  }

  Future<List> getItems() async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnItemname ASC");
    return result.toList();
  }

  Future<int> getCount() async{
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName")
    );
  }

  Future<NoDoItem> getItem(int id) async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName "
        "WHERE $columnId = $id");
    if(result.length == 0){
      return null;
    }else{
      return new NoDoItem.fromMap(result.first);
    }
  }

  Future<int> deleteItem(int id) async{
    var dbClient = await db;
    return await dbClient.delete(tableName,
        where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> updateItem(NoDoItem item) async{
    var dbClient = await db;
    return await dbClient.update(tableName,
        item.toMap(), where: "$columnId = ?", whereArgs: [item.id]
    );
  }

  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }

}

