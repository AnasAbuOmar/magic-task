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

  ScrollController scrollControllerCreate = ScrollController();
  ScrollController scrollControllerEditPage = ScrollController();

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
              setsId: element.setsId,
              workoutId: workoutId,
              numberOfRepetitions: element.numberOfRepetitions,
              weight: element.weight);
          newSetList.add(setsModel);
        }

        emit(state.copyWith(setsOfWorkoutList: newSetList));
        SetsService setsService = SetsService();
        for (var element in state.setsOfWorkoutList) {
          setsService.createSet(setsModel: element);
        }

        emit(state.copyWith(status: WorkoutStateStatus.success));
      } else {
        emit(state.copyWith(status: WorkoutStateStatus.error));
      }
    }).whenComplete(() => reset());

    emit(state.copyWith(status: WorkoutStateStatus.loading));
  }

  void updateWorkout({required String workoutId}) {
    emit(state.copyWith(status: WorkoutStateStatus.loading));
    WorkoutService service = WorkoutService();

    service
        .updateWorkout(
            workoutId: workoutId,
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
              setsId: element.setsId,
              workoutId: workoutId,
              numberOfRepetitions: element.numberOfRepetitions,
              weight: element.weight);

          newSetList.add(setsModel);
        }

        emit(state.copyWith(setsOfWorkoutList: newSetList));

        removeSetBySetId(workoutId: state.selectedWorkoutId).then((value) {
          SetsService setsService = SetsService();
          for (var element in state.setsOfWorkoutList) {
            setsService.createSet(setsModel: element);
          }
        });

        emit(state.copyWith(status: WorkoutStateStatus.success));
      } else {
        emit(state.copyWith(status: WorkoutStateStatus.error));
      }
    });

    emit(state.copyWith(status: WorkoutStateStatus.loading));
  }

  Future<void> removeSetBySetId({required String workoutId}) async {
    SetsService setsService = SetsService();
    await setsService.sets.get().then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        if (element.get('workoutId') == workoutId) {
          setsService.removeSet(setsId: element.get('setsId'));
        }
      }
    });
  }

  void removeWorkoutByWorkoutId({required String workoutId}) {
    WorkoutService workoutService = WorkoutService();
    workoutService.removeWorkoutId(workoutId: workoutId);
  }

  void selectWorkout({required String newWorkout}) => emit(state.copyWith(
        dropdownWorkoutName: newWorkout,
      ));

  void selectWorkoutId({required String selectedWorkoutId}) =>
      emit(state.copyWith(
        selectedWorkoutId: selectedWorkoutId,
      ));

  void scrollDownCreatePage() => Future.delayed(
        const Duration(milliseconds: 200),
        () => scrollControllerCreate.animateTo(
            scrollControllerCreate.position.maxScrollExtent,
            duration: const Duration(
              milliseconds: 500,
            ),
            curve: Curves.fastLinearToSlowEaseIn),
      );

  void scrollDownEditPage() => Future.delayed(
        const Duration(milliseconds: 200),
        () => scrollControllerEditPage.animateTo(
            scrollControllerEditPage.position.maxScrollExtent,
            duration: const Duration(
              milliseconds: 500,
            ),
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

  void addSets({required SetsModel setsModel, required WorkoutPageMode mode}) {
    List<SetsModel> oldSetList = [];
    for (var element in state.setsOfWorkoutList) {
      oldSetList.add(element);
    }
    oldSetList.add(setsModel);

    emit(state.copyWith(setsOfWorkoutList: oldSetList));
    switch (mode) {
      case WorkoutPageMode.create:
        scrollDownCreatePage();
        break;
      case WorkoutPageMode.edit:
        scrollDownEditPage();
        break;
    }
  }

  void removeSets() {
    List<SetsModel> oldSetList = [];
    for (var element in state.setsOfWorkoutList) {
      oldSetList.add(element);
    }
    oldSetList.removeLast();

    emit(state.copyWith(setsOfWorkoutList: oldSetList));
  }

  void updateSets({required SetsModel setsModel, required int index}) {
    List<SetsModel> oldSetList = [];
    for (var element in state.setsOfWorkoutList) {
      oldSetList.add(element);
    }
    oldSetList[index] = setsModel;
    emit(state.copyWith(setsOfWorkoutList: oldSetList));
  }

  void reset() {
    emit(state.copyWith(
      status: WorkoutStateStatus.init,
      dropdownWorkoutName: AppConstants.barbellRow,
      weight: 5,
      numberOfRepetitions: 2,
      setsOfWorkoutList: const [],
    ));
  }
}
