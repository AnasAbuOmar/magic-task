
import 'package:magic_task/main_imports.dart';

class MainFunctions {
  static Future<void> preStart() async {
    await setDeviceOrientation();
    await CacheHelper.init();
    await initializationFirebase();
    FirestoreStorage.init();
  }

  static Future<void> initializationNativeSplash() async {
    await Future.delayed(
        const Duration(seconds: AppConstants.flutterNativeSplashDuration));
    FlutterNativeSplash.remove();
  }

  static Future<void> setDeviceOrientation() async =>
      await SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      );

  static Future<void> initializationFirebase() async =>
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

  static getBlocProviders() {
    return [
      BlocProvider(
        create: (_) => AppCubit(),
      ),
      BlocProvider(
        create: (_) => WorkoutCubit(),
      ),
    ];
  }
}
