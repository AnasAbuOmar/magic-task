import 'package:magic_task/main_imports.dart';

class DropDownListWidget extends StatelessWidget {
  const DropDownListWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final WorkoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
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
        );
      }),
    );
  }
}
