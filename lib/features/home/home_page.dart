import 'package:flutter/material.dart';

import 'package:movement/features/workout_list/workout_list_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WorkoutListTab(),
    );
  }
}
