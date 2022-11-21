import 'package:magic_task/main_imports.dart';
import 'package:magic_task/pages/workout_page/widgets/widgets.dart';

class AddRemoveWidget extends StatelessWidget {
  const AddRemoveWidget({
    Key? key,
    required this.mode,
  }) : super(key: key);

  final WorkoutPageMode mode;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Row(
            children: [
              state.setsOfWorkoutList.length < 10
                  ? AddWidget(mode: mode)
                  : const SizedBox(),
              SizedBox(
                width: 20.w,
              ),
              state.setsOfWorkoutList.isNotEmpty
                  ? const RemoveWidget()
                  : const SizedBox(),
            ],
          ),
        );
      }),
    );
  }
}
