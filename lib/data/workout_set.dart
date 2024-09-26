
import 'exercise.dart';

class WorkoutSet {
  WorkoutSet({
    required this.exercise,
    required this.weight,
    required this.repetitions,
  });

  final Exercise exercise;
  final int weight;
  final int repetitions;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkoutSet &&
      other.exercise == exercise &&
      other.weight == weight &&
      other.repetitions == repetitions;
  }

  @override
  int get hashCode => exercise.hashCode ^ weight.hashCode ^ repetitions.hashCode;

  WorkoutSet copyWith({
    Exercise? exercise,
    int? weight,
    int? repetitions,
  }) {
    return WorkoutSet(
      exercise: exercise ?? this.exercise,
      weight: weight ?? this.weight,
      repetitions: repetitions ?? this.repetitions,
    );
  }

  @override
  String toString() {
    return 'WorkoutSet{exercise: $exercise, weight: $weight, repetitions: $repetitions}';
  }
}