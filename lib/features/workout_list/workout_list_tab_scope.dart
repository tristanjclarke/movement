import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:movement/data/workout.dart';
import 'package:movement/data/workout_repository.dart';
import 'package:provider/provider.dart';

class WorkoutListTabScope extends ChangeNotifier {
  WorkoutListTabScope({
    required WorkoutRepository workoutRepository,
  }) : _workoutRepository = workoutRepository;

  factory WorkoutListTabScope.of(BuildContext context) {
    return WorkoutListTabScope(
      workoutRepository: context.read(),
    );
  }

  late final WorkoutRepository _workoutRepository;

  StreamSubscription? _workoutSubscription;

  List<Workout>? get workouts => _workouts;
  List<Workout>? _workouts;

  Future<void> initialize() async {
    _workouts = await _workoutRepository.list();

    notifyListeners();

    _workoutSubscription = _workoutRepository.events.listen((_) async {
      _workouts = await _workoutRepository.list();

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _workoutSubscription?.cancel();

    super.dispose();
  }

  Future<void> deleteWorkout(String id) async {
    await _workoutRepository.delete(id);
  }
}
