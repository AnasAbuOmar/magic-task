import 'package:flutter/material.dart';
import 'package:magic_task/blocs/workout/workout_cubit.dart';
import 'package:magic_task/pages/workout_page/view/view.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({Key? key, required this.mode, this.workoutId})
      : super(key: key);
  final WorkoutPageMode mode;
  final String? workoutId;

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case WorkoutPageMode.create:
        return const Scaffold(
          body: WorkoutView(),
        );

      case WorkoutPageMode.edit:
        return Scaffold(
          body: WorkoutEditView(workoutId: workoutId ?? ''),
        );
    }
  }
}
