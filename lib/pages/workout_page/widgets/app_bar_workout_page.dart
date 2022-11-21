import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:magic_task/main_imports.dart';

class AppBarWorkoutPage extends StatelessWidget {
  const AppBarWorkoutPage({
    Key? key,
    required this.isPinned,
  }) : super(key: key);

  final bool isPinned;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
      return SliverAppBar(
        title: Text(AppLocale.get(context)?.workoutScreen ?? ''),
        pinned: true,
        expandedHeight: 200.h,
        flexibleSpace: FlexibleSpaceBar(
          title: isPinned ? const SizedBox() : Text(state.dropdownWorkoutName),
          centerTitle: true,
        ),
        actions: [
          IconButton(
              onPressed: () {
                AppCubit.get(context).changeLocale();
              },
              icon: const Icon(FontAwesomeIcons.language))
        ],
      );
    });
  }
}
