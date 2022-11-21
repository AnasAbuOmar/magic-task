import 'package:magic_task/main_imports.dart';
import 'package:magic_task/pages/workout_page/widgets/widgets.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({Key? key}) : super(key: key);

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  bool isPinned = false;

  @override
  void initState() {
    addListenerToController();
    super.initState();
  }

  void addListenerToController() {
    if (mounted) {
      final cubit = WorkoutCubit.get(context);

      cubit.scrollControllerCreate.addListener(() {
        if (!isPinned &&
            cubit.scrollControllerCreate.hasClients &&
            cubit.scrollControllerCreate.offset > kToolbarHeight) {
          setState(() {
            isPinned = true;
          });
        } else if (isPinned &&
            cubit.scrollControllerCreate.hasClients &&
            cubit.scrollControllerCreate.offset < kToolbarHeight) {
          setState(() {
            isPinned = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
      final cubit = WorkoutCubit.get(context);
      return CustomScrollView(
        controller: cubit.scrollControllerCreate,
        slivers: [
          AppBarWorkoutPage(isPinned: isPinned),
          const WorkoutImageWidget(),
          DropDownListWidget(cubit: cubit),
          const SetsListWidget(),
          const AddRemoveWidget(mode: WorkoutPageMode.create),
          SliverToBoxAdapter(
            child: SizedBox(height: 50.h),
          ),
          const AddEditButton(
            mode: WorkoutPageMode.create,
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 50.h),
          ),
        ],
      );
    });
  }
}
