import 'package:movement/data/sqflite/sqflite_exercise.dart';
import 'package:movement/data/workout_set.dart';

extension SqfliteWorkoutSet on WorkoutSet {
  static WorkoutSet fromMap(Map<String, dynamic> map) {
    return WorkoutSet(
      exercise: SqfliteExercise.fromMap(
        map[SqfliteWorkoutSetColumns.exercise] as Map<String, dynamic>,
      ),
      weight: map[SqfliteWorkoutSetColumns.weight] as int,
      repetitions: map[SqfliteWorkoutSetColumns.repetitions] as int,
    );
  }

  Map<String, dynamic> toSqfliteMap() {
    return {
      SqfliteWorkoutSetColumns.exercise: exercise.toSqfliteMap(),
      SqfliteWorkoutSetColumns.weight: weight,
      SqfliteWorkoutSetColumns.repetitions: repetitions,
    };
  }
}

class SqfliteWorkoutSetColumns {
  const SqfliteWorkoutSetColumns._();

  static const exercise = 'exercise';
  static const weight = 'weight';
  static const repetitions = 'reps';
}
