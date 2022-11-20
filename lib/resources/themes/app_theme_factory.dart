import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magic_task/utils/constants.dart';

part 'app_theme_state.dart';

part 'app_text_theme.dart';

part 'app_radius.dart';

part 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: AppConstants.promoFont,
  primaryColor: primaryColor,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: primaryLightColor,
    secondary: secondaryColor,
    onSecondary: whiteColor,
    error: redColor,
    onError: whiteColor,
    background: backgroundColor,
    onBackground: blackColor,
    surface: primaryColor,
    onSurface: secondaryColor,

  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(whiteColor),
    fillColor: MaterialStateProperty.resolveWith(
      (states) => states.isEmpty ? primaryColor : secondaryColor,
    ),
    overlayColor: MaterialStateProperty.all(primaryLightColor),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(secondaryColor),
    trackColor: MaterialStateProperty.resolveWith(
      (states) => states.isEmpty ? primaryLightColor : primaryColor,
    ),
    overlayColor: MaterialStateProperty.all(primaryLightColor),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith(
      (states) => states.isEmpty ? primaryColor : secondaryColor,
    ),
    overlayColor: MaterialStateProperty.all(primaryLightColor),
  ),
  appBarTheme: const AppBarTheme(
    color: primaryColor,
    iconTheme: IconThemeData(color: whiteColor),
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24.0,
      color: whiteColor,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: primaryColor,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(primary: primaryColor),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(primary: primaryColor),
  ),
  listTileTheme: const ListTileThemeData(
    minLeadingWidth: 0,
    iconColor: false ? whiteColor : secondaryColor,
    textColor: false ? whiteColor : secondaryColor,
    selectedColor: false ? blackColor : whiteColor,
  ),
  textTheme: AppTextTheme.textTheme,
);


ThemeData darkTheme = ThemeData(
  fontFamily: AppConstants.promoFont,
  primaryColor: primaryColor,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: primaryColor,
    onPrimary: primaryLightColor,
    secondary: secondaryColor,
    onSecondary: blackColor,
    error: redColor,
    onError: blackColor,
    background: backgroundColor,
    onBackground: whiteColor,
    surface: primaryColor,
    onSurface: secondaryColor,

  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(primaryLightColor),
    fillColor: MaterialStateProperty.resolveWith(
      (states) => states.isEmpty ? primaryLightColor : secondaryColor,
    ),
    overlayColor: MaterialStateProperty.all(primaryLightColor),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(secondaryColor),
    trackColor: MaterialStateProperty.resolveWith(
      (states) => states.isEmpty ? primaryLightColor : primaryColor,
    ),
    overlayColor: MaterialStateProperty.all(primaryLightColor),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith(
      (states) => states.isEmpty ? primaryLightColor : secondaryColor,
    ),
    overlayColor: MaterialStateProperty.all(primaryLightColor),
  ),
  appBarTheme: const AppBarTheme(
    color: primaryColor,
    iconTheme: IconThemeData(color: blackColor),
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24.0,
      color: blackColor,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: primaryColor,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(primary: primaryColor),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(primary: primaryColor),
  ),
  listTileTheme: const ListTileThemeData(
    minLeadingWidth: 0,
    iconColor: false ? whiteColor : secondaryColor,
    textColor: false ? whiteColor : secondaryColor,
    selectedColor: false ? blackColor : whiteColor,
  ),
  textTheme: AppTextTheme.darkTextTheme,
);
