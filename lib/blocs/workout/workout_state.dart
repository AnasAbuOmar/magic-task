part of 'workout_cubit.dart';

enum WorkoutStateStatus { init, remove, change, success, loading, error }

enum WorkoutPageMode { create, edit }

class WorkoutState extends Equatable {
  final WorkoutStateStatus status;

  // final int numberOfSets;
  final String dropdownWorkoutName;
  final double weight;
  final int numberOfRepetitions;
  final Map<String, dynamic> selectedGif;
  final List<SetsModel> setsOfWorkoutList;

  static const List<String> workoutList = [
    AppConstants.barbellRow,
    AppConstants.benchPress,
    AppConstants.shoulderPress,
    AppConstants.deadlift,
    AppConstants.squat,
  ];

  const WorkoutState({
    this.status = WorkoutStateStatus.init,
    this.dropdownWorkoutName = AppConstants.barbellRow,
    this.weight = 5,
    this.numberOfRepetitions = 2,
    this.selectedGif = const {AppConstants.barbellRow: Images.barbellRow},
    this.setsOfWorkoutList = const [],
  });

  @override
  List<Object> get props => [
        status,
        dropdownWorkoutName,
        weight,
        numberOfRepetitions,
        selectedGif,
        setsOfWorkoutList,
      ];

  WorkoutState copyWith({
    WorkoutStateStatus? status,
    String? dropdownWorkoutName,
    double? weight,
    int? numberOfRepetitions,
    Map<String, dynamic>? selectedGif,
    List<SetsModel>? setsOfWorkoutList,
  }) {
    return WorkoutState(
      status: status ?? this.status,
      dropdownWorkoutName: dropdownWorkoutName ?? this.dropdownWorkoutName,
      weight: weight ?? this.weight,
      numberOfRepetitions: numberOfRepetitions ?? this.numberOfRepetitions,
      selectedGif: selectedGif ?? this.selectedGif,
      setsOfWorkoutList: setsOfWorkoutList ?? this.setsOfWorkoutList,
    );
  }
}
