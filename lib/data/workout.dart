import 'workout_set.dart';

class Workout {
  Workout({
    required this.id,
    required this.name,
    required this.dateTime,
    required this.sets,
  });

  final String id;
  final String name;
  final DateTime dateTime;
  final List<WorkoutSet> sets;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Workout &&
        other.id == id &&
        other.name == name &&
        other.dateTime == dateTime &&
        other.sets == sets;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ dateTime.hashCode ^ sets.hashCode;

  Workout copyWith({
    String? id,
    String? name,
    DateTime? dateTime,
    List<WorkoutSet>? sets,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      dateTime: dateTime ?? this.dateTime,
      sets: sets ?? this.sets,
    );
  }

  @override
  String toString() {
    return 'Workout{id: $id, name: $name, dateTime: $dateTime, sets: $sets}';
  }
}
