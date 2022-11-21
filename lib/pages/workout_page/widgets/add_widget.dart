import 'package:magic_task/firebase/database/sets/sets.dart';
import 'package:magic_task/main_imports.dart';

class AddWidget extends StatelessWidget {
  const AddWidget({
    Key? key,
    required this.mode,
  }) : super(key: key);
  final WorkoutPageMode mode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
      return Expanded(
        child: InkWell(
          onTap: () {
            if (state.setsOfWorkoutList.length < 10) {
              WorkoutCubit.get(context).addSets(
                  mode: mode,
                  setsModel: SetsModel(
                      setsId: 'setsId',
                      workoutId: 'workoutId',
                      numberOfRepetitions: 2,
                      weight: 5.0));
            } else {
              print('greater than 10');
            }
          },
          child: Row(
            children: [
              const Icon(Icons.add_circle, color: primaryColor),
              const Expanded(
                child: Divider(thickness: 2, color: primaryColor),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text('Add set',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: primaryColor, fontWeight: FontWeight.bold)),
              ),
              const Expanded(
                child: Divider(thickness: 2, color: primaryColor),
              ),
            ],
          ),
        ),
      );
    });
  }
}
