import 'workout.dart';

abstract class WorkoutRepository {
  Stream<void> get events;

  Future<List<Workout>> list();

  Future<Workout?> get(String id);

  Future<void> insert(Workout workout);

  Future<void> replace(Workout workout);

  Future<void> delete(String id);
}
