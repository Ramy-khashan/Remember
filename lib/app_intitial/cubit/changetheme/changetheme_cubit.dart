
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'changetheme_states.dart';

class ChangeTheme extends Cubit<ChangeThemeState> {
  ChangeTheme() : super(InitialState());
  bool isDark = false;
  static ChangeTheme get(ctx) => BlocProvider.of(ctx);
  ThemeMode themeMode = ThemeMode.light;
  String themeType = '';
  savedTheme() async {
    SharedPreferences.getInstance().then((value) {
      themeType = value.get("theme").toString();
      themeMode = themeType == "dark" ? ThemeMode.dark : ThemeMode.light;
      isDark = themeType == "dark" ? true : false;
      emit(GetValFromSPState());
    });
  }

  changeTheme() async {
    isDark = !isDark;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    emit(ChangeToDarkState());
    await SharedPreferences.getInstance()
        .then((value) => value.setString("theme", isDark ? "dark" : "light"));
  }
  
}
