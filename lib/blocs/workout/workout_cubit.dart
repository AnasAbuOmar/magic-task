import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:magic_task/firebase/database/sets/sets.dart';
import 'package:magic_task/firebase/database/workout/workout.dart';
import 'package:magic_task/main_imports.dart';
import 'package:magic_task/utils/assets/json_files.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutState()) {
    loadImages();
  }

  static WorkoutCubit get(context) => BlocProvider.of(context);

  final ScrollController scrollController = ScrollController();

  void createWorkout() {
    emit(state.copyWith(status: WorkoutStateStatus.loading));
    WorkoutService service = WorkoutService();

    service
        .createWorkout(
            workoutModel: WorkoutModel(
      workoutName: state.dropdownWorkoutName,
      numberOfSets: state.setsOfWorkoutList.length,
    ))
        .then((workoutId) {
      if (workoutId != '') {
        List<SetsModel> oldSetList = [];
        List<SetsModel> newSetList = [];
        for (var element in state.setsOfWorkoutList) {
          oldSetList.add(element);
        }
        for (var element in oldSetList) {
          SetsModel setsModel = SetsModel(
              workoutId: workoutId,
              numberOfRepetitions: element.numberOfRepetitions,
              weight: element.weight);
          newSetList.add(setsModel);
        }

        emit(state.copyWith(setsOfWorkoutList: newSetList));
        SetsService setsService = SetsService();
        for (var element in state.setsOfWorkoutList) {
          setsService.createWorkout(setsModel: element);
        }

        emit(state.copyWith(status: WorkoutStateStatus.success));
      } else {
        emit(state.copyWith(status: WorkoutStateStatus.error));
      }
    });
    emit(state.copyWith(status: WorkoutStateStatus.loading));
  }

  void selectWorkout({required String newWorkout}) => emit(state.copyWith(
        dropdownWorkoutName: newWorkout,
      ));

  void scrollDown() => Future.delayed(
        const Duration(milliseconds: 500),
        () => scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn),
      );

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  Future<void> loadImages() async {
    Map<String, dynamic> map = await parseJsonFromAssets(JsonFiles.gifImages);
    emit(state.copyWith(selectedGif: map));
  }

  void addSets({required SetsModel setsModel}) {
    List<SetsModel> oldSetList = [];
    for (var element in state.setsOfWorkoutList) {
      oldSetList.add(element);
    }
    oldSetList.add(setsModel);

    emit(state.copyWith(setsOfWorkoutList: oldSetList));
    scrollDown();
  }

  void updateSets({required SetsModel setsModel, required int index}) {
    List<SetsModel> oldSetList = [];
    for (var element in state.setsOfWorkoutList) {
      oldSetList.add(element);
    }
    oldSetList[index] = setsModel;
    emit(state.copyWith(setsOfWorkoutList: oldSetList));
  }

  void removeSetsAt({required int index}) {
    List<SetsModel> oldSetList = [];
    for (var element in state.setsOfWorkoutList) {
      oldSetList.add(element);
    }
    oldSetList.removeAt(index);
    emit(state.copyWith(setsOfWorkoutList: oldSetList));
  }

  void reset() {
    emit(state.copyWith(
      status: WorkoutStateStatus.init,
      dropdownWorkoutName: AppConstants.barbellRow,
      weight: 5,
      numberOfRepetitions: 2,
      selectedGif: const {AppConstants.barbellRow: Images.barbellRow},
      setsOfWorkoutList: const [],
    ));
    /*    this.status = WorkoutStateStatus.init,
    this.dropdownWorkoutName = AppConstants.barbellRow,
    this.weight = 5,
    this.numberOfRepetitions = 2,
    this.selectedGif = const {AppConstants.barbellRow: Images.barbellRow},
    this.setsOfWorkoutList = const [],*/
  }
}
