import 'package:equatable/equatable.dart';
import 'package:magic_task/main_imports.dart';
import 'package:magic_task/pages/workout_list_page/view/view.dart';
import 'package:magic_task/pages/workout_page/view/view.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState()) {
    initLang();
    initPages();
  }

  static AppCubit get(context) => BlocProvider.of(context);

  void changeLocale() {
    final bool isLangCached = CacheHelper.getData(key: lang) != null;
    final bool isLangEn = CacheHelper.getData(key: lang) == AppConstants.en;
    if (isLangCached) {
      if (isLangEn) {
        emitArLang();
        saveArLang();
      } else {
        emitEnLang();
        saveEnLang();
      }
    } else {
      initLang();
    }
  }

  void saveEnLang() => CacheHelper.saveData(key: lang, value: AppConstants.en);

  void saveArLang() => CacheHelper.saveData(key: lang, value: AppConstants.ar);

  void emitEnLang() =>
      emit(state.copyWith(locale: const Locale(AppConstants.en)));

  void emitArLang() =>
      emit(state.copyWith(locale: const Locale(AppConstants.ar)));

  void initLang() {
    if (CacheHelper.getData(key: lang) == null) {
      emitEnLang();
      saveEnLang();
    } else {
      if (CacheHelper.getData(key: lang) == AppConstants.ar) {
        emitArLang();
      } else {
        emitEnLang();
      }
    }
  }

  void initPages() {
    final List<Widget> pages = [
      const WorkoutPage(mode: WorkoutPageMode.create),
      const WorkoutListPage(),
    ];
    emit(state.copyWith(pages: pages));
  }

  void changeBottomNavBarIndex({required int newIndex}) =>
      emit(state.copyWith(bottomNavBarIndex: newIndex));


}
