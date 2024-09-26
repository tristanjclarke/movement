import 'package:movement/data/exercise.dart';

extension SqfliteExercise on Exercise {
  static Exercise fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map[SqfliteExerciseColumns.name] as String,
    );
  }

  Map<String, dynamic> toSqfliteMap() {
    return {
      SqfliteExerciseColumns.name: name,
    };
  }
}

class SqfliteExerciseColumns {
  const SqfliteExerciseColumns._();

  static const name = 'name';
}
