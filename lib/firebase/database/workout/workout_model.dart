

class WorkoutModel {
  late String _workoutName;
  late int _numberOfSets;

  WorkoutModel({
    required String workoutName,
    required int numberOfSets,
  }) {
    _workoutName = workoutName;
    _numberOfSets = numberOfSets;
  }

  String get workoutName => _workoutName;

  int get numberOfSets => _numberOfSets;
}
