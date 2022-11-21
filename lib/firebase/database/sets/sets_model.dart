class SetsModel {
  late String _setsId;
  late String _workoutId;
  late int _numberOfRepetitions;
  late double _weight;

  SetsModel({
    required String setsId,
    required String workoutId,
    required int numberOfRepetitions,
    required double weight,
  }) {
    _setsId = setsId;
    _workoutId = workoutId;
    _numberOfRepetitions = numberOfRepetitions;
    _weight = weight;
  }

  String get setsId => _setsId;

  String get workoutId => _workoutId;

  int get numberOfRepetitions => _numberOfRepetitions;

  double get weight => _weight;
}
