// ignore_for_file: prefer_conditional_assignment

import 'package:guruku_student/data/model/teacher_model/teacher_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper.instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper.instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblBookmark = 'bookmark';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/guruku.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCrreate);
    return db;
  }

  void _onCrreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblBookmark (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        avatar TEXT, 
        price TEXT, 
        address TEXT, 
        type_teaching TEXT
      );
  ''');
  }

  Future<int> insertBookmark(TeacherTable teacher) async {
    final db = await database;
    return await db!.insert(_tblBookmark, teacher.toJson());
  }

  Future<int> removeBookmark(TeacherTable teacher) async {
    final db = await database;
    return await db!.delete(
      _tblBookmark,
      where: 'id = ?',
      whereArgs: [teacher.id],
    );
  }

  Future<Map<String, dynamic>?> getBookmarkById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getBookmarkList() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblBookmark,
    );

    return results;
  }
}
