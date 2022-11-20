import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:magic_task/main_imports.dart';
import 'package:magic_task/resources/l10n/app_locale.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> destinations = [
      NavigationDestination(
        icon: const Icon(
          FontAwesomeIcons.dumbbell,
          color: primaryColor,
        ),
        selectedIcon: const Icon(
          FontAwesomeIcons.dumbbell,
          color: primaryLightColor,
        ),
        label: AppLocale.get(context)?.workoutScreen ?? '',
      ),
      NavigationDestination(
        icon: const Icon(
          FontAwesomeIcons.list,
          color: primaryColor,
        ),
        selectedIcon: const Icon(
          FontAwesomeIcons.list,
          color: primaryLightColor,
        ),
        label: AppLocale.get(context)?.workoutListScreen ?? '',
      ),
    ];

    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      final cubit = AppCubit.get(context);
      return NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: primaryColor,
          labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: primaryColor,
            fontSize: 12,
          )),
        ),
        child: NavigationBar(
          backgroundColor: whiteColor,
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: state.bottomNavBarIndex,
          onDestinationSelected: (int newIndex) {
            cubit.changeBottomNavBarIndex(newIndex: newIndex);
          },
          destinations: destinations,
        ),
      );
    });
  }
}
