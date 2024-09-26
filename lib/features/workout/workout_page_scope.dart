import 'package:flutter/widgets.dart';
import 'package:movement/data/exercise.dart';
import 'package:movement/data/exercises.dart';
import 'package:movement/data/workout.dart';
import 'package:movement/data/workout_repository.dart';
import 'package:movement/data/workout_set.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class WorkoutPageScope extends ChangeNotifier {
  WorkoutPageScope({
    required List<Exercise> exercises,
    required WorkoutRepository workoutRepository,
  }) {
    _exercises = exercises;
    _workoutRepository = workoutRepository;
  }

  factory WorkoutPageScope.of(BuildContext context) {
    return WorkoutPageScope(
      exercises: Exercises.list,
      workoutRepository: context.read(),
    );
  }

  late WorkoutRepository _workoutRepository;

  bool get canSave => name != null && sets != null && sets!.isNotEmpty;

  List<Exercise>? get exercises => _exercises;
  List<Exercise>? _exercises;

  String? get name => _name;
  String? _name;

  set name(String? value) {
    if (value == _name) return;
    _name = value;

    notifyListeners();
  }

  List<WorkoutSet>? get sets => _sets;
  List<WorkoutSet>? _sets;

  void addSet(Exercise exercise) {
    final set = WorkoutSet(
      exercise: exercise,
      weight: 0,
      repetitions: 0,
    );

    _sets ??= [];
    _sets!.add(set);

    notifyListeners();
  }

  void updateSet(int index, WorkoutSet set) {
    _sets![index] = set;

    notifyListeners();
  }

  void removeSet(int index) {
    _sets!.removeAt(index);

    notifyListeners();
  }

  Future<void> save() async {
    await _workoutRepository.insert(
      Workout(
        id: const Uuid().v4(),
        name: name ?? 'Some workout',
        dateTime: DateTime.now(),
        sets: sets ?? [],
      ),
    );
  }
}
