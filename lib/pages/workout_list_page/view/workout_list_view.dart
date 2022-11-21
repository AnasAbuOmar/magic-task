import 'package:intl/intl.dart';
import 'package:magic_task/firebase/database/database.dart';
import 'package:magic_task/main_imports.dart';
import 'package:magic_task/pages/workout_page/view/view.dart';

class WorkoutListView extends StatelessWidget {
  const WorkoutListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: WorkoutService().workout.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(AppLocale.get(context)?.workoutListScreen ?? ''),
              ),
              snapshot.hasData
                  ? SliverList(
                      delegate: SliverChildListDelegate(snapshot.data!.docs
                          .map((doc) => Card(
                                child: ListTile(
                                  onTap: () => NavigatorHelper.navigateTo(
                                      context,
                                      WorkoutPage(
                                        mode: WorkoutPageMode.edit,
                                        workoutId: doc['workoutId'],
                                      )),
                                  leading: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primaryColor),
                                    width: 60.sp,
                                    child: Center(
                                        child: Text(
                                      '${snapshot.data!.docs.indexOf(doc) + 2}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(color: whiteColor),
                                    )),
                                  ),
                                  title: Text(
                                    '${'Workout'} : ${doc['workoutName']}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(color: blackColor),
                                  ),
                                  subtitle: Text(
                                      DateFormat('dd/MM/yyyy, HH:mm a')
                                          .format(doc['createAt'].toDate()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              color:
                                                  blackColor.withOpacity(0.5),
                                              fontSize: 20.sp)),
                                  trailing: IconButton(
                                      onPressed: () => WorkoutCubit.get(context)
                                          .removeWorkoutByWorkoutId(
                                              workoutId: doc['workoutId']),
                                      icon: const Icon(Icons.delete)),
                                ),
                              ))
                          .toList()),
                    )
                  : snapshot.hasError
                      ? const SliverToBoxAdapter(
                          child: SizedBox(),
                        )
                      : const SliverFillRemaining(
                          fillOverscroll: false,
                          hasScrollBody: false,
                          child: Center(
                              child: CircularProgressIndicator.adaptive()),
                        ),
            ],
          );
        });
  }
}
