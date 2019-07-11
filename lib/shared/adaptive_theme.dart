import 'package:flutter/material.dart';

final ThemeData _androidTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  accentColor: Colors.deepPurple,
  brightness: Brightness.light,
  buttonColor: Colors.red,
);

final ThemeData _iOSTheme = ThemeData(
  primarySwatch: Colors.grey,
  accentColor: Colors.blue,
  brightness: Brightness.light,
  buttonColor: Colors.blue,
);

ThemeData getAdaptiveThemeData(BuildContext context) {
  return Theme.of(context).platform == TargetPlatform.android
      ? _androidTheme
      : _iOSTheme;
}
