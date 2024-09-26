import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'package:movement/data/database.dart' as data;
import 'package:movement/data/sqflite/sqflite_workout_repository.dart';

class Sqflite implements data.Database {
  Sqflite._({
    Database? database,
    required String path,
    required int version,
  })  : _database = database,
        _path = path,
        _version = version;

  factory Sqflite.create({
    required String databasePath,
    required int databaseVersion,
  }) {
    return Sqflite._(
      path: databasePath,
      version: databaseVersion,
    );
  }

  final String _path;
  final int _version;

  Database? _database;

  Database get instance {
    assert(
      _database != null,
      'Open database before using the instance.',
    );

    return _database!;
  }

  @override
  Future<void> open() async {
    if (_database != null && _database!.isOpen) {
      return;
    }

    final instance = await openDatabase(
      _path,
      version: _version,
      onCreate: _onCreate,
      // TODO: Handle migrations here
      onUpgrade: (_, __, ___) {},
    );

    _database = instance;
  }

  @override
  Future<void> close() async {
    if (_database != null) await _database!.close();
  }

  static Future<void> _onCreate(Database database, int version) async {
    await database.transaction((transaction) async {
      await transaction.execute(
        SqfliteWorkoutRepository.createTableStatement,
      );
    });
  }

  @override
  Future<void> delete() {
    return deleteDatabase(_path);
  }
}
