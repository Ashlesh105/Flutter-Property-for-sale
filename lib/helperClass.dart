import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'User_model_class.dart';
import 'property_model.dart'; // Import your Property model

class DatabaseHelper {
  static const String _databaseName = 'property_database.db';
  static const String _tableName = 'properties';
  static const _databaseVersion = 1;

  static const tableUser = 'user';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnEmail = 'email';
  static const columnPhoneNumber = 'phoneNumber';
  static const columnProfileImage = 'profileImage';
  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        minPrice INTEGER,
        maxPrice INTEGER,
        imageUrl TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $tableUser (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL,
        $columnPhoneNumber TEXT NOT NULL,
        $columnProfileImage TEXT NOT NULL
      )
    ''');
  }
  Future<int> insertUser(User user) async {
    Database db = await instance.database;
    return await db.insert(tableUser, user.toMap());
  }

  Future<User?> getUser(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableUser, where: '$columnId = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return User(
        id: maps[0][columnId],
        name: maps[0][columnName],
        email: maps[0][columnEmail],
        phoneNumber: maps[0][columnPhoneNumber], profileImage: maps[0][columnProfileImage],
      );
    }
    return null;
  }

  Future<int> updateUser(User user) async {
    Database db = await instance.database;
    return await db.update(tableUser, user.toMap(), where: '$columnId = ?', whereArgs: [user.id]);
  }

  Future<int> insertProperty(Map<String, dynamic> property) async {
    Database db = await instance.database;
    return await db.insert(_tableName, property);
  }

  Future<List<Property>> getProperties() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (index) {
      return Property.fromMap(maps[index]);
    });
  }
}
