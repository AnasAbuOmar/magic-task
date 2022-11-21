import 'package:magic_task/main_imports.dart';

class WorkoutImageWidget extends StatelessWidget {
  const WorkoutImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
      return SliverToBoxAdapter(
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
      );
    });
  }
}
