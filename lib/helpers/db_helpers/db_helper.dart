import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static const placesTable = 'places';

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    final finalPath = path.join(dbPath, 'great_places.db');

    return await sql.openDatabase(
      finalPath,
      version: 1,
      onCreate: (sql.Database db, int version) async {
        await db.execute('CREATE TABLE $placesTable (id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
    );

  }
  
  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    await db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
