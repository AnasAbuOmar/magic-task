part of 'app_cubit.dart';

enum AppStateStatus { init, remove, change, success, loading, error }

class AppState extends Equatable {
  final AppStateStatus status;
  final Locale locale;
  final List<Widget> pages;
  final int bottomNavBarIndex;

  const AppState({
    this.status = AppStateStatus.init,
    this.locale = const Locale(AppConstants.en),
    this.pages = const [SizedBox(), SizedBox()],
    this.bottomNavBarIndex = 0,
  });

  @override
  List<Object> get props => [
        status,
        locale,
        pages,
        bottomNavBarIndex,
      ];

  AppState copyWith({
    AppStateStatus? status,
    Locale? locale,
    List<Widget>? pages,
    int? bottomNavBarIndex,
  }) {
    return AppState(
        status: status ?? this.status,
        locale: locale ?? this.locale,
        pages: pages ?? this.pages,
      bottomNavBarIndex: bottomNavBarIndex ?? this.bottomNavBarIndex
    );
  }
}
