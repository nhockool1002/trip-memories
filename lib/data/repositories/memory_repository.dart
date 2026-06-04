import 'package:sqflite/sqflite.dart';

import '../local/app_database.dart';
import '../models/memory_item.dart';
import '../services/image_storage_service.dart';

class MemoryRepository {
  const MemoryRepository(this._database, this._imageStorageService);

  final AppDatabase _database;
  final ImageStorageService _imageStorageService;

  Future<List<MemoryItem>> getAll() async {
    final db = await _database.database;
    final rows = await db.query(
      'memories',
      orderBy: 'updated_at DESC',
    );
    return rows.map(MemoryItem.fromMap).toList();
  }

  Future<MemoryItem?> getById(String id) async {
    final db = await _database.database;
    final rows = await db.query(
      'memories',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (rows.isEmpty) {
      return null;
    }
    return MemoryItem.fromMap(rows.first);
  }

  Future<void> save(MemoryItem memory) async {
    final db = await _database.database;
    await db.insert(
      'memories',
      memory.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String id) async {
    final memory = await getById(id);
    if (memory == null) {
      return;
    }

    final db = await _database.database;
    await db.delete(
      'memories',
      where: 'id = ?',
      whereArgs: [id],
    );
    await _imageStorageService.deleteManagedImages(memory.imagePaths);
  }
}
