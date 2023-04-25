import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Model/CartModelLocal.dart';
import 'Model/FavouriteLocalModel.dart';
import 'Model/cart_model.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();

  static final _databaseName = 'my_database.db';
  static final _databaseVersion = 5;

  static final table = 'product';
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

  factory DbHelper() => _instance;

  DbHelper.internal();

  static Database _db;

  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }
    //define the path to the database
    // var databasesPath = await getDatabasesPath();
    String path = join(await getDatabasesPath(), _databaseName);
    _db = await openDatabase(path, version: 3,
        onCreate: (Database db, int v) async {
      //create tables
      await db.execute("CREATE TABLE $table ("
          // "uniqe_id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$columnId INTEGER PRIMARY KEY,"
          "$columnName TEXT NULL,"
          "$columnImage TEXT NULL,"
          "$columnDescription TEXT NULL,"
          "$columnPrice REAL NULL,"
          "$columnOfferPrice REAL NULL,"
          "$columnPrice2 REAL NULL,"
          "$columnTotalPrice REAL NULL,"
          "$columnQuantity INTEGER NULL,"
          "$columnOfferName TEXT NULL,"
          "$columnSelectedTypeName TEXT NULL,"
          "$columnMessage TEXT NULL,"
          "$columnSubItems TEXT NULL"
          ")");
      await db.execute("CREATE TABLE favorite ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "img TEXT,"
          "price REAL"
          ")");
    });
    return _db;
  }

  Future<int> addToCartTable(CartModel cartMedelLocal) async {
    Database db = await createDatabase();
    //db.rawInsert('insert into courses value')
    return db.insert(table, cartMedelLocal.toJson());
  }

  Future<int> addToCart(CartMedelLocal cartMedelLocal) async {
    Database db = await createDatabase();
    //db.rawInsert('insert into courses value')
    return db.insert(table, cartMedelLocal.toMap());
  }

  Future<List> allProduct() async {
    Database db = await createDatabase();
    //db.rawQuery('select * from courses');
    return db.query(table);
  }

  Future<int> delete(int id) async {
    Database db = await createDatabase();
    return db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCart() async {
    Database db = await createDatabase();
    return db.delete(table);
  }

  Future<int> updateCourseTable(CartModel product) async {
    Database db = await createDatabase();
    var x = await db.update(table, product.toJson(),
        where: 'id = ?', whereArgs: [product.id]);
    return x;
  }

  Future<int> updateCourse(CartMedelLocal product) async {
    Database db = await createDatabase();
    var x = await db.update(table, product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
    return x;
  }


  /////////////////////////////////
  Future<int> addToFavorite(FavoriteModelLocal favoriteModelLocal) async {
    Database db = await createDatabase();
    //db.rawInsert('insert into courses value')
    return db.insert('favorite', favoriteModelLocal.toMap());
  }

  Future<List> allFavorite() async {
    Database db = await createDatabase();
    //db.rawQuery('select * from courses');
    return db.query('favorite');
  }

  Future<int> deleteFavorite(int id) async {
    Database db = await createDatabase();
    return db.delete('favorite', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateFavorite(FavoriteModelLocal favoriteModelLocal) async {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    Database db = await createDatabase();
    return await db.update('favorite', favoriteModelLocal.toMap(),
        where: 'id = ?', whereArgs: [favoriteModelLocal.id]);
  }

  Future<bool> isProductFoundInFavouriteTable(int id) async {
    Database db = await createDatabase();
    List<Map> productList =
        await db.rawQuery('SELECT * FROM favorite where id = ?', [id]);
    if (productList.length > 0) {
      return true;
    }
    return false;
  }
}
