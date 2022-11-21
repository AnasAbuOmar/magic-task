import 'package:magic_task/firebase/database/sets/sets.dart';
import 'package:magic_task/firebase/database/workout/workout_service.dart';
import 'package:magic_task/main_imports.dart';
import 'package:magic_task/pages/workout_page/widgets/widgets.dart';

class WorkoutEditView extends StatefulWidget {
  const WorkoutEditView({Key? key, required this.workoutId}) : super(key: key);
  final String workoutId;

  @override
  State<WorkoutEditView> createState() => _WorkoutEditViewState();
}

class _WorkoutEditViewState extends State<WorkoutEditView> {
  bool isPinned = false;

  @override
  void initState() {
    if (widget.workoutId.isEmpty) {
      NavigatorHelper.pop(context);
    }

    getPageInfo();

    addListenerToController();
    super.initState();
  }

  void getPageInfo() {
    final cubit = WorkoutCubit.get(context);
    cubit.reset();
    getWorkout(cubit);
    getSets(cubit);
  }

  void getWorkout(WorkoutCubit cubit) {
    cubit.selectWorkoutId(selectedWorkoutId: widget.workoutId);
    WorkoutService()
        .workout
        .doc(widget.workoutId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        cubit.selectWorkout(newWorkout: documentSnapshot['workoutName']);
      }
    });
  }

  void getSets(WorkoutCubit cubit) {
    SetsService()
        .sets
        .where('workoutId', isEqualTo: widget.workoutId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        cubit.addSets(
            mode: WorkoutPageMode.edit,
            setsModel: SetsModel(
                setsId: doc['setsId'],
                workoutId: doc['workoutId'],
                numberOfRepetitions: doc['numberOfRepetitions'],
                weight: doc['weight']));
      }
    });
  }

  void addListenerToController() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (mounted) {
        final cubit = WorkoutCubit.get(context);

        cubit.scrollControllerEditPage.addListener(() {
          if (!isPinned &&
              cubit.scrollControllerEditPage.hasClients &&
              cubit.scrollControllerEditPage.offset > kToolbarHeight) {
            setState(() {
              isPinned = true;
            });
          } else if (isPinned &&
              cubit.scrollControllerEditPage.hasClients &&
              cubit.scrollControllerEditPage.offset < kToolbarHeight) {
            setState(() {
              isPinned = false;
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (mounted) {
        WorkoutCubit.get(context).reset();
      }
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
      final cubit = WorkoutCubit.get(context);

      return CustomScrollView(
        controller: cubit.scrollControllerEditPage,
        slivers: [
          AppBarWorkoutPage(isPinned: isPinned),
          const WorkoutImageWidget(),
          DropDownListWidget(cubit: cubit),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => EditSetsWidget(index: index),
                childCount: state.setsOfWorkoutList.length),
          ),
          const AddRemoveWidget(mode: WorkoutPageMode.edit),
          SliverToBoxAdapter(
            child: SizedBox(height: 50.h),
          ),
          const AddEditButton(mode: WorkoutPageMode.edit),
          SliverToBoxAdapter(
            child: SizedBox(height: 50.h),
          ),
        ],
      );
    });
  }
}
