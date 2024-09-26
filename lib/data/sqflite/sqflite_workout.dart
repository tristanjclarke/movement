import 'dart:convert';

import 'package:movement/data/workout.dart';

import 'sqflite_workout_set.dart';

extension SqfliteWorkout on Workout {
  static Workout fromMap(Map<String, dynamic> map) {
    final decodedSets = jsonDecode(map[SqfliteWorkoutColumns.sets] as String);

    return Workout(
      id: map[SqfliteWorkoutColumns.id] as String,
      name: map[SqfliteWorkoutColumns.name] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        map[SqfliteWorkoutColumns.dateTime] as int,
      ),
      sets: (decodedSets as List)
          .map((set) => SqfliteWorkoutSet.fromMap(set))
          .toList(),
    );
  }

  Map<String, dynamic> toSqfliteMap() {
    return {
      SqfliteWorkoutColumns.id: id,
      SqfliteWorkoutColumns.name: name,
      SqfliteWorkoutColumns.dateTime: dateTime.millisecondsSinceEpoch,
      SqfliteWorkoutColumns.sets: jsonEncode(
        sets.map((set) => set.toSqfliteMap()).toList(),
      ),
    };
  }
}

class SqfliteWorkoutColumns {
  const SqfliteWorkoutColumns._();

  static const id = 'id';
  static const name = 'name';
  static const dateTime = 'dateTime';
  static const sets = 'sets';
}
