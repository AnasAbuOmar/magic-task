import 'package:magic_task/main_imports.dart';
import 'package:magic_task/pages/homepage/view/home_page.dart';
import 'package:magic_task/resources/l10n/app_locale.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomePage();
    return Scaffold(
        body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocale.get(context)?.helloWorld ?? ''),
          Text(AppLocale.get(context)?.helloWorld ?? ''),
          Text(AppLocale.get(context)?.helloWorld ?? ''),
          Text(AppLocale.get(context)?.helloWorld ?? ''),
          Text(AppLocale.get(context)?.helloWorld ?? ''),
          Text(AppLocale.get(context)?.helloWorld ?? ''),
          Text(AppLocale.get(context)?.helloWorld ?? ''),
          Text(AppLocale.get(context)?.helloWorld ?? ''),
          MaterialButton(
            onPressed: () {
              final cubit = WorkoutCubit.get(context);
              cubit.createWorkout();
            },
            child: const Text('data'),
          )
        ],
      ),
    );
  }
}
