part of 'app_theme_factory.dart';

class AppTheme {
  static ButtonStyle mainBlockButtonStyle({
    double height = 65,
    Color color = primaryColor,
    Color onPrimary = whiteColor,
    OutlinedBorder? shape,
  }) {
    return ElevatedButton.styleFrom(
      minimumSize: Size(double.maxFinite, height),
      primary: color,
      shape: shape,
      onPrimary: onPrimary,
    );
  }

  static ButtonStyle largeBlockButton(
      {Color color = primaryColor,
      Color onPrimary = whiteColor,
      OutlinedBorder? shape,
      bool rounded = true}) {
    return mainBlockButtonStyle(
      color: color,
      onPrimary: onPrimary,
      shape: rounded && shape == null
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )
          : shape,
      height: 60,
    );
  }
}
