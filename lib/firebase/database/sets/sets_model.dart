class SetsModel {
  late String _workoutId;
  late int _numberOfRepetitions;
  late double _weight;

  SetsModel({
    required String workoutId,
    required int numberOfRepetitions,
    required double weight,
  }) {
    _workoutId = workoutId;
    _numberOfRepetitions = numberOfRepetitions;
    _weight = weight;
  }

  String get workoutId => _workoutId;

  int get numberOfRepetitions => _numberOfRepetitions;

  double get weight => _weight;
}
