import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  Database? _database;

  Future<Database> get database async {
    final existingDatabase = _database;
    if (existingDatabase != null) {
      return existingDatabase;
    }

    final dbPath = await getDatabasesPath();
    final database = await openDatabase(
      p.join(dbPath, 'trip_memories.db'),
      version: 1,
      onCreate: _onCreate,
    );
    _database = database;
    return database;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE memories (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        note TEXT,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        image_paths TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
  }
}
