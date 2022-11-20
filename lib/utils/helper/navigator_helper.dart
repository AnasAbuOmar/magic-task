import 'package:flutter/material.dart';

class NavigatorHelper {
  static void navigateTo(context, widget, {fullscreenDialog}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
        fullscreenDialog: fullscreenDialog ?? true,
      ));

  static void navigateToReplacement(context, widget, {fullscreenDialog}) =>
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => widget,
            fullscreenDialog: fullscreenDialog ?? true,
          ));

  static void navigateToAndRemoveUntil(context, widget, {fullscreenDialog}) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => widget,
            fullscreenDialog: fullscreenDialog ?? true,
          ),
          (Route<dynamic> route) => false);

  static void pop(context) => Navigator.pop(context);
}
