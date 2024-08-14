import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../services/shared_pref/shared_pref.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(_getInitialThemeMode());

 static ThemeMode _getInitialThemeMode() {
  final themePreference = SharedPref().getBool("theme");
  
  if (themePreference == null) {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }
  
  return themePreference ? ThemeMode.dark : ThemeMode.light;
}

  void toggleTheme(bool isDarkMode) {
    final themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    SharedPref().setBool("theme", isDarkMode);
    emit(themeMode);
  }
}
