import 'package:flutter/material.dart';

import 'app_color.dart';

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    useMaterial3: true,
    primaryColor: AppColor.mainColor2);
ThemeData light = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  cardColor: Colors.white,
  cardTheme: const CardTheme(),
  primaryColor: const Color.fromARGB(255, 225, 220, 203),
);
