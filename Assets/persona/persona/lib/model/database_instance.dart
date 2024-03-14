import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  var table = "isClicktable";
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'persona.db');

    // Create the database
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    // Create your table(s) here
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_event INTEGER,
        isClicked INTEGER
      )
    ''');
  }

  // CRUD Operations

  // Create operation
  Future<int> insert(Map<String, dynamic> row) async {
    Database? dbClient = await db;
    return await dbClient!.insert("$table", row);
  }

  // Read operation
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? dbClient = await db;
    return await dbClient!.query('$table');
  }

  // Update operation
  Future<int> update(Map<String, dynamic> row) async {
    Database? dbClient = await db;
    return await dbClient!.update('$table', row,
        where: 'id = ?', whereArgs: [row['id']]);
  }

  // Delete operation
  Future<int> delete(int id) async {
    Database? dbClient = await db;
    return await dbClient!.delete('$table', where: 'id = ?', whereArgs: [id]);
  }

  //Delete all
  Future<int> deleteAll() async {
    Database? dbClient = await db;
    return await dbClient!.delete('$table');
  }


  Future<bool> checkisClick()async{
    Database? dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient!.query(
      '$table',
      where: 'isClicked = ?',
      whereArgs: [0],
    );
    if(result.isEmpty)return false;
    else return true;
  }

  // Get the last inserted ID
  Future<int?> getLastInsertedId() async {
    Database? dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient!.rawQuery('SELECT last_insert_rowid() as id');
    int? lastInsertedId = result.isNotEmpty ? result.first['id'] : 0;
    return lastInsertedId;
  }
  //check by ID
  Future<bool> checkID(int id_event) async {
    Database? dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient!.query(
      '$table',
      where: 'id_event = ?',
      whereArgs: [id_event],
    );
    if(result.isEmpty){
      return false;
    }return true;
  }

  //get id
  Future<int?> getIdByEvent(int id_event) async {
    Database? dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient!.query(
      '$table',
      where: 'id_event = ?',
      whereArgs: [id_event],
    );
    if (result.isNotEmpty) {
      // Mengembalikan ID jika ditemukan
      return result.first['id'] as int;
    } else {
      return null; // Mengembalikan null jika tidak ditemukan
    }
  }

  //Query Row by ID
  Future queryRowById(int id_event) async {
    Database? dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient!.query(
      '$table',
      where: 'id_event = ?',
      whereArgs: [id_event],
    );
    if (result.isNotEmpty) {
    // Check if the event is clicked
      int isClicked = result.first['isClicked'];

      return isClicked;
    } else {
      return null;
    }
  }


  // Close the database
  Future close() async {
    Database? dbClient = await db;
    dbClient!.close();
  }
}
