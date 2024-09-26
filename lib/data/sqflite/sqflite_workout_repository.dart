import 'dart:async';

import 'package:collection/collection.dart';

import 'package:movement/data/sqflite/sqflite.dart';
import 'package:movement/data/workout.dart';
import 'package:movement/data/workout_repository.dart';

import 'sqflite_workout.dart';

class SqfliteWorkoutRepository implements WorkoutRepository {
  SqfliteWorkoutRepository(Sqflite database) : _database = database;

  static const tableName = 'workouts';

  static const createTableStatement = '''
          CREATE TABLE $tableName (
            ${SqfliteWorkoutColumns.id} TEXT PRIMARY KEY,
            ${SqfliteWorkoutColumns.name} TEXT,
            ${SqfliteWorkoutColumns.dateTime} INT,
            ${SqfliteWorkoutColumns.sets} TEXT
          )''';

  final Sqflite _database;

  late final _controller = StreamController.broadcast();

  @override
  Stream<void> get events => _controller.stream;

  @override
  Future<List<Workout>> list() async {
    final query = await _database.instance.query(tableName);
    final records = query.map((record) => SqfliteWorkout.fromMap(record));

    return records.toList();
  }

  @override
  Future<Workout?> get(String id) async {
    assert(id.isNotEmpty);

    final query = await _database.instance.query(tableName);
    final records = query.map((record) => SqfliteWorkout.fromMap(record));

    return records.singleWhereOrNull((workout) => workout.id == id);
  }

  @override
  Future<void> insert(Workout workout) async {
    assert(workout.id.isNotEmpty);

    await _database.instance.insert(
      tableName,
      workout.toSqfliteMap(),
    );

    _controller.add(null);
  }

  @override
  Future<void> replace(Workout workout) async {
    assert(workout.id.isNotEmpty);

    await _database.instance.update(
      tableName,
      workout.toSqfliteMap(),
      where: '${SqfliteWorkoutColumns.id} = ?',
      whereArgs: [workout.id],
    );

    _controller.add(null);
  }

  @override
  Future<void> delete(String id) async {
    assert(id.isNotEmpty);

    await _database.instance.delete(
      tableName,
      where: '${SqfliteWorkoutColumns.id} = ?',
      whereArgs: [id],
    );

    _controller.add(null);
  }
}
