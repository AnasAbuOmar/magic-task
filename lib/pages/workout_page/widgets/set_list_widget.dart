import 'package:magic_task/main_imports.dart';
import 'package:magic_task/pages/workout_page/widgets/widgets.dart';

class SetsListWidget extends StatelessWidget {
  const SetsListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
                (context, index) => SetsWidget(index: index),
            childCount: state.setsOfWorkoutList.length),
      );
    });
  }
}