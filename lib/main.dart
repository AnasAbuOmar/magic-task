import 'package:magic_task/main_imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainFunctions.initializationNativeSplash();
  await MainFunctions.preStart();
  runApp(const InitLayer());
}

class InitLayer extends StatelessWidget {
  const InitLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(630, 1370),
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: MainFunctions.getBlocProviders(),
          child: const MagicTaskApp(),
        );
      },
    );
  }
}
