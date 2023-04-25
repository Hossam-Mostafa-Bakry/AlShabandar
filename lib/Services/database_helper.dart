import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = 'my_database.db';
  static final _databaseVersion = 5;

  static final table = 'my_table';
  static final columnId = 'id';
  static final columnName = 'name';
  static final columnImage = 'img';
  static final columnDescription = 'description';
  static final columnPrice = 'price';
  static final columnPrice2 = 'price2';
  static final columnOfferPrice = 'offerPrice';
  static final columnTotalPrice = 'totalPrice';
  static final columnQuantity = 'quantity';
  static final columnOfferName = 'offerName';
  static final columnSelectedTypeName = 'selectedTypeName';
  static final columnMessage = 'message';
  static final columnSubItems = 'subItems';

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $table ("
        "$columnId INTEGER PRIMARY KEY,"
        "$columnName TEXT NOT NULL,"
        "$columnImage TEXT,"
        "$columnDescription TEXT,"
        "$columnPrice REAL,"
        "$columnPrice2 REAL,"
        "$columnOfferPrice REAL,"
        "$columnTotalPrice REAL,"
        "$columnQuantity INTEGER,"
        "$columnOfferName TEXT,"
        "$columnSelectedTypeName TEXT,"
        "$columnMessage TEXT,"
        "$columnSubItems TEXT NOT NULL"
        ")");
  }

  Future<int> insertModel(Map<String, dynamic> model) async {
    final db = await database;

    return await db.insert(table, model);
  }

  Future<List<Map<String, dynamic>>> getAllModels() async {
    final db = await database;

    return await db.query(table);
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCart() async {
    Database db = await database;
    return db.delete(table);
  }

}
