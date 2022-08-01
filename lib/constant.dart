import 'package:flutter/material.dart';

Color mainColor1 = Colors.teal.withOpacity(.7);
Color mainColor2 = Colors.orange.shade700;

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.white,
    primaryColor: mainColor1);
ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    accentColor: Colors.black,
    primaryColor: mainColor1);
