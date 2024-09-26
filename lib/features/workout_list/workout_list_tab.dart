import 'package:flutter/material.dart';
import 'package:movement/data/workout_set.dart';

import 'package:movement/features/workout/workout_page.dart';
import 'package:provider/provider.dart';

import 'workout_list_tab_scope.dart';

class WorkoutListTab extends StatelessWidget {
  const WorkoutListTab({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ChangeNotifierProvider(
      create: (_) => WorkoutListTabScope.of(context)..initialize(),
      builder: (context, _) {
        final scope = context.watch<WorkoutListTabScope>();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: colorScheme.primary,
            title: Text(
              'Workout List',
              style: TextStyle(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  for (final workout in scope.workouts ?? [])
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _WorkoutItem(
                        name: workout.name,
                        date: workout.dateTime,
                        sets: workout.sets,
                        onDeletePressed: () => scope.deleteWorkout(workout.id),
                      ),
                    ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const WorkoutPage(),
                ),
              );
            },
            shape: const CircleBorder(),
            tooltip: 'Add Workout',
            child: const Icon(
              Icons.add_rounded,
            ),
          ),
        );
      },
    );
  }
}

class _WorkoutItem extends StatelessWidget {
  const _WorkoutItem({
    required this.name,
    required this.date,
    required this.sets,
    required this.onDeletePressed,
  });

  final String name;
  final DateTime date;
  final List<WorkoutSet> sets;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  onPressed: onDeletePressed,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${date.year}-${date.month}-${date.day}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            for (final set in sets)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    set.exercise.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Weight: ${set.weight} Repetitions: ${set.repetitions}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
