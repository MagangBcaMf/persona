import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLogin {
  static final DatabaseLogin _instance = DatabaseLogin.internal();
  var table = "user";
  factory DatabaseLogin() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseLogin.internal();

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');

    // Create the database
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  // Update operation
  Future<int> update(Map<String, dynamic> row) async {
    Database? dbClient = await db;
    return await dbClient!.update('$table', row,
        where: 'id = ?', whereArgs: [row['id']]);
  }

  void _onCreate(Database db, int newVersion) async {
    // Create your table(s) here
    final String createTableQuery = '''
      CREATE TABLE IF NOT EXISTS $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_user INTEGER
      )
    ''';

    final String insertQuery = '''
      INSERT INTO $table (id_user) VALUES (123)
    ''';

    await db.execute(createTableQuery);
    await db.execute(insertQuery);
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

  //Delete all
  Future<int> deleteAll() async {
    Database? dbClient = await db;
    return await dbClient!.delete('$table');
  }

  // Get the last inserted ID
  Future<int?> getLastInsertedId() async {
    Database? dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient!.rawQuery('SELECT last_insert_rowid() as id');
    int? lastInsertedId = result.isNotEmpty ? result.first['id'] : 0;
    return lastInsertedId;
  }

  Future <int> checkData(int id) async{
    Database? dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient!.query(
      '$table',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first['id_user'];
    } else {
      return -1; 
    }
  }

  //Query Row by ID
  Future <int?> queryRowById(int id_event) async {
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
