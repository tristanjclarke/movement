import 'package:flutter/material.dart';
import 'package:movement/data/exercise.dart';
import 'package:movement/features/workout/workout_page_scope.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return ChangeNotifierProvider(
      create: (_) => WorkoutPageScope.of(context),
      builder: (context, _) {
        final scope = context.watch<WorkoutPageScope>();

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Workout'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Name your workout',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Workout name',
                      ),
                      onChanged: (value) =>
                          scope.name = value.isEmpty ? null : value,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Sets',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    if (scope.sets == null || scope.sets!.isEmpty)
                      const Card(
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Center(
                            child: Text('Press the + button to add a set'),
                          ),
                        ),
                      ),
                    for (final set in scope.sets ?? [])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _SetItem(
                          exerciseName: set.exercise.name,
                          weight: set.weight,
                          repetitions: set.repetitions,
                          onDeletePressed: () {
                            final setIndex = scope.sets!.indexOf(set);

                            scope.removeSet(setIndex);
                          },
                          onWeightChanged: (value) {
                            final weight = int.tryParse(value) ?? 0;

                            final setIndex = scope.sets!.indexOf(set);
                            final updatedSet = set.copyWith(weight: weight);

                            scope.updateSet(setIndex, updatedSet);
                          },
                          onRepetitionsChanged: (value) {
                            final repetitions = int.tryParse(value) ?? 0;

                            final setIndex = scope.sets!.indexOf(set);
                            final updatedSet = set.copyWith(
                              repetitions: repetitions,
                            );

                            scope.updateSet(setIndex, updatedSet);
                          },
                        ),
                      ),
                    const SizedBox(height: 24),
                    Center(
                      child: FilledButton(
                        onPressed: !scope.canSave
                            ? null
                            : () async {
                                await scope.save();

                                Navigator.pop(context);
                              },
                        child: const Center(
                          child: Text('Save your workout'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 64 + MediaQuery.of(context).viewPadding.bottom,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => _ExerciseOptions(
                    options: scope.exercises ?? [],
                    onSelected: (value) {
                      scope.addSet(value);

                      Navigator.pop(context);
                    },
                  ),
                );
              },
              shape: const CircleBorder(),
              tooltip: 'Add Set',
              backgroundColor: colorScheme.primary,
              child: Icon(
                Icons.add_rounded,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SetItem extends StatelessWidget {
  const _SetItem({
    required this.exerciseName,
    required this.weight,
    required this.repetitions,
    required this.onDeletePressed,
    required this.onWeightChanged,
    required this.onRepetitionsChanged,
  });

  final String exerciseName;
  final int weight;
  final int repetitions;
  final VoidCallback? onDeletePressed;
  final ValueChanged<String> onWeightChanged;
  final ValueChanged<String> onRepetitionsChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  exerciseName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: onDeletePressed,
                  icon: const Icon(Icons.delete_rounded),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Weight',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: onWeightChanged,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Repetitions',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: onRepetitionsChanged,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseOptions extends StatelessWidget {
  const _ExerciseOptions({
    required this.options,
    required this.onSelected,
  });

  final List<Exercise> options;
  final ValueChanged<Exercise> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        for (final exercise in options)
          ListTile(
            title: Text(exercise.name),
            onTap: () => onSelected(exercise),
          ),
      ],
    );
  }
}
