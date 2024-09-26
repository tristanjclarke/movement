import 'package:flutter/material.dart';
import 'package:movement/data/workout_repository.dart';
import 'package:provider/provider.dart';

import 'features/home/home_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.workoutRepository,
  });

  final WorkoutRepository workoutRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WorkoutRepository>.value(value: workoutRepository),
      ],
      child: MaterialApp(
        title: 'Movement',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
