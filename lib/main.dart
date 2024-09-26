import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'app.dart';
import 'data/sqflite/sqflite.dart';
import 'data/sqflite/sqflite_workout_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!Platform.isIOS) return;

  String documentDirectoryPath;

  if (Platform.isIOS) {
    final library = await getLibraryDirectory();

    documentDirectoryPath = library.path;
  } else {
    documentDirectoryPath = await sqflite.getDatabasesPath();
  }

  final databasePath = join(documentDirectoryPath, 'embrace.db');
  final database = Sqflite.create(
    databasePath: databasePath,
    // TODO: Handle migrations here
    databaseVersion: 1,
  );
  await database.open();

  runApp(
    App(
      workoutRepository: SqfliteWorkoutRepository(database),
    ),
  );
}
