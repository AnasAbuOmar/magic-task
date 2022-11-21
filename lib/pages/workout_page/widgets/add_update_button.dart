import 'package:magic_task/main_imports.dart';

class AddEditButton extends StatelessWidget {
  const AddEditButton({
    Key? key,
    required this.mode,
  }) : super(key: key);

  final WorkoutPageMode mode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
      return SliverToBoxAdapter(
        child: state.setsOfWorkoutList.isNotEmpty
            ? state.status == WorkoutStateStatus.loading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : MaterialButton(
                    color: primaryColor,
                    height: 80.h,
                    onPressed: () {
                      switch (mode) {
                        case WorkoutPageMode.create:
                          WorkoutCubit.get(context).createWorkout();
                          break;
                        case WorkoutPageMode.edit:
                          WorkoutCubit.get(context).updateWorkout(
                              workoutId: state.selectedWorkoutId);
                          break;
                      }
                    },
                    child: Text(
                      mode == WorkoutPageMode.create
                          ? 'Add workout'
                          : 'Update workout',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: whiteColor),
                    ))
            : const SizedBox(),
      );
    });
  }
}
