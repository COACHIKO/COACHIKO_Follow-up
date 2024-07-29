import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../services/shared_pref/shared_pref.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(_getInitialThemeMode());

  static ThemeMode _getInitialThemeMode() {
    final isDarkMode = SharedPref().getBool("theme") ?? false;
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme(bool isDarkMode) {
    final themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    SharedPref().setBool("theme", isDarkMode);
    emit(themeMode);
  }
}
