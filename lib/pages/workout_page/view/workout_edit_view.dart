import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:magic_task/firebase/database/sets/sets.dart';
import 'package:magic_task/firebase/database/workout/workout_service.dart';
import 'package:magic_task/main_imports.dart';

class WorkoutEditView extends StatefulWidget {
  const WorkoutEditView({Key? key, required this.workoutId}) : super(key: key);
  final String workoutId;

  @override
  State<WorkoutEditView> createState() => _WorkoutEditViewState();
}

class _WorkoutEditViewState extends State<WorkoutEditView> {
  bool isPinned = false;

  @override
  void initState() {
    if (widget.workoutId.isEmpty) {
      NavigatorHelper.pop(context);
    }

    final cubit = WorkoutCubit.get(context);
    cubit.reset();
    WorkoutService()
        .workout
        .doc(widget.workoutId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        cubit.selectWorkout(newWorkout: documentSnapshot['workoutName']);
      }
    });
    SetsService()
        .sets
        .where('workoutId', isEqualTo: widget.workoutId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        cubit.addSets(
            setsModel: SetsModel(
                workoutId: doc['workoutId'],
                numberOfRepetitions: doc['numberOfRepetitions'],
                weight: doc['weight']));
      }
    });

    if (mounted) {
      cubit.scrollController.addListener(() {
        if (!isPinned &&
            cubit.scrollController.hasClients &&
            cubit.scrollController.offset > kToolbarHeight) {
          setState(() {
            isPinned = true;
          });
        } else if (isPinned &&
            cubit.scrollController.hasClients &&
            cubit.scrollController.offset < kToolbarHeight) {
          setState(() {
            isPinned = false;
          });
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    final cubit = WorkoutCubit.get(context);
    cubit.scrollController.dispose();
    cubit.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
      final cubit = WorkoutCubit.get(context);

      return CustomScrollView(
        controller: cubit.scrollController,
        slivers: [
          SliverAppBar(
            title: Text(AppLocale.get(context)?.workoutScreen ?? ''),
            pinned: true,
            expandedHeight: 200.h,
            flexibleSpace: FlexibleSpaceBar(
              title:
                  isPinned ? const SizedBox() : Text(state.dropdownWorkoutName),
              centerTitle: true,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeLocale();
                  },
                  icon: const Icon(FontAwesomeIcons.language))
            ],
          ),
          SliverToBoxAdapter(
            child: Image.asset(
              state.selectedGif[state.dropdownWorkoutName] ?? '',
              height: 400.h,
              width: 400.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                Images.barbellRow,
                height: 400.h,
                width: 400.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(AppLocale.get(context)?.selectWorkout ?? '')),
                  Expanded(
                    child: DropdownButton(
                      value: state.dropdownWorkoutName,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: WorkoutState.workoutList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newWorkout) {
                        if (newWorkout != null) {
                          cubit.selectWorkout(newWorkout: newWorkout);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => EditSetsWidget(index: index),
                childCount: state.setsOfWorkoutList.length),
          ),
          SliverToBoxAdapter(
            child: state.setsOfWorkoutList.length < 10
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: InkWell(
                      onTap: () {
                        if (state.setsOfWorkoutList.length < 10) {
                          WorkoutCubit.get(context).addSets(
                              setsModel: SetsModel(
                                  workoutId: 'workoutId',
                                  numberOfRepetitions: 2,
                                  weight: 5.0));
                        } else {
                          print('greater than 10');
                        }
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.add_circle),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: blackColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text('Add set'),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: blackColor,
                            ),
                          ),
                          Icon(Icons.add_circle),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 50.h),
          ),
          SliverToBoxAdapter(
            child: state.setsOfWorkoutList.isNotEmpty
                ? MaterialButton(
                    color: primaryColor,
                    height: 80.h,
                    onPressed: () {
                      cubit.createWorkout();
                    },
                    child: Text(
                      'Add workout',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: whiteColor),
                    ))
                : const SizedBox(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 50.h),
          ),
        ],
      );
    });
  }
}

class EditSetsWidget extends StatefulWidget {
  const EditSetsWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  State<EditSetsWidget> createState() => _EditSetsWidgetState();
}

class _EditSetsWidgetState extends State<EditSetsWidget> {
  int numberOfRepetitions = 2;
  double weight = 5.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
      return Card(
        child: Row(
          children: [
            Container(
              color: primaryColor,
              width: 40.sp,
              height: 120,
              child: Center(
                  child: Text(
                '${widget.index + 1}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: whiteColor),
              )),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Expanded(child: Text('Repetitions')),
                      Expanded(
                        child: SpinBox(
                          min: 2,
                          max: 100,
                          value: state.setsOfWorkoutList[widget.index]
                              .numberOfRepetitions
                              .toDouble(),
                          onChanged: (value) {
                            numberOfRepetitions = value.toInt();
                            WorkoutCubit.get(context).updateSets(
                                setsModel: SetsModel(
                                    workoutId: state
                                        .setsOfWorkoutList[widget.index]
                                        .workoutId,
                                    numberOfRepetitions: numberOfRepetitions,
                                    weight: state
                                        .setsOfWorkoutList[widget.index].weight
                                        .toDouble()),
                                index: widget.index);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text('Weight')),
                      Expanded(
                        child: SpinBox(
                          decimals: 1,
                          step: 0.5,
                          acceleration: 0.5,
                          min: 5,
                          max: 500,
                          value: state.setsOfWorkoutList[widget.index].weight,
                          onChanged: (value) {
                            weight = value;
                            WorkoutCubit.get(context).updateSets(
                                setsModel: SetsModel(
                                    workoutId: state
                                        .setsOfWorkoutList[widget.index]
                                        .workoutId,
                                    numberOfRepetitions: state
                                        .setsOfWorkoutList[widget.index]
                                        .numberOfRepetitions
                                        .toInt(),
                                    weight: weight),
                                index: widget.index);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
