import 'package:magic_task/main_imports.dart';

class RemoveWidget extends StatelessWidget {
  const RemoveWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
      return Expanded(
        child: InkWell(
          onTap: () {
            if (state.setsOfWorkoutList.isNotEmpty) {
              WorkoutCubit.get(context).removeSets();
            } else {
              print('greater than 10');
            }
          },
          child: Row(
            children: [
              const Expanded(
                child: Divider(thickness: 2, color: redColor),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text('Remove set',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: redColor, fontWeight: FontWeight.bold)),
              ),
              const Expanded(
                child: Divider(thickness: 2, color: redColor),
              ),
              const Icon(Icons.remove_circle, color: redColor),
            ],
          ),
        ),
      );
    });
  }
}
