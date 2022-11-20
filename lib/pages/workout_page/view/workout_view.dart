import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:magic_task/firebase/database/sets/sets.dart';
import 'package:magic_task/main_imports.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({Key? key}) : super(key: key);

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  bool isPinned = false;

  @override
  void initState() {
    if (mounted) {
      final cubit = WorkoutCubit.get(context);

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
                (context, index) => SetsWidget(index: index),
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

class SetsWidget extends StatefulWidget {
  const SetsWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  State<SetsWidget> createState() => _SetsWidgetState();
}

class _SetsWidgetState extends State<SetsWidget> {
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
                          value: 2,
                          onChanged: (value) {
                            numberOfRepetitions = value.toInt();
                            WorkoutCubit.get(context).updateSets(
                                setsModel: SetsModel(
                                    workoutId: 'workoutId',
                                    numberOfRepetitions: numberOfRepetitions,
                                    weight: weight),
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
                          value: 5,
                          onChanged: (value) {
                            weight = value;
                            WorkoutCubit.get(context).updateSets(
                                setsModel: SetsModel(
                                    workoutId: 'workoutId',
                                    numberOfRepetitions: numberOfRepetitions,
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
