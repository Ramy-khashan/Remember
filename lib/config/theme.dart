import 'package:flutter/material.dart';

import '../core/utils/app_color.dart';

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black, 
    useMaterial3: true, 
    primaryColor: AppColor.mainColor1);
ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true, 
    primaryColor: AppColor.mainColor1);
