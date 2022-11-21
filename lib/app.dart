import 'package:magic_task/main_imports.dart';

class MagicTaskApp extends StatelessWidget {
  const MagicTaskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: state.locale,
          title: AppConstants.appName,
          home: const Root(),
        );
      }),
    );
  }
}
