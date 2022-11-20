import 'package:flutter/material.dart';
import 'package:magic_task/pages/workout_list_page/view/workout_list_view.dart';

class WorkoutListPage extends StatelessWidget {
  const WorkoutListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WorkoutListView(),
    );
  }
}
