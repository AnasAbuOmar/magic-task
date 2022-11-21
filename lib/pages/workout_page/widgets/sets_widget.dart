import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:magic_task/firebase/database/sets/sets.dart';
import 'package:magic_task/main_imports.dart';

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
                                    setsId: 'setsId',
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
                                    setsId: 'setsId',
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
