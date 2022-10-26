import 'package:restaurant_app/data/models/restaurants.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tableFavouriteResto = 'favourite_restaurants';

  Future<Database> _initializeDb() async {
    var path = getDatabasesPath();
    var db = openDatabase(
      '$path/restopedia.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tableFavouriteResto (
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating DOUBLE
        )
      ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<void> insertFavouriteResto(RestaurantModel restaurant) async {
    final db = await database;
    await db!.insert(_tableFavouriteResto, restaurant.toJson());
  }

  Future<List<RestaurantModel>> getFavouriteResto(String? keyword) async {
    final db = await database;
    if (keyword != null) {
      List<Map<String, dynamic>> results = await db!.rawQuery(
          "SELECT * FROM $_tableFavouriteResto WHERE name LIKE '%$keyword%'");
      return results
          .map(
            (e) => RestaurantModel.fromJson(e),
          )
          .toList();
    } else {
      List<Map<String, dynamic>> results =
          await db!.query(_tableFavouriteResto);
      return results.map((e) => RestaurantModel.fromJson(e)).toList();
    }
  }

  Future<void> removeFavouriteResto(String id) async {
    final db = await database;
    await db!.delete(
      _tableFavouriteResto,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
