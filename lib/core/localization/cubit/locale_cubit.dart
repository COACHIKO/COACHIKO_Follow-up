import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../coachiko_app.dart';
import '../../../main.dart';
import '../language_cache_helper.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: const Locale('en')));

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
        await LanguageCacheHelper().getCachedLanguageCode();
    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    emit(ChangeLocaleState(locale: Locale(languageCode)));
    _restartApp();
  }

  void _restartApp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(navigatorKey.currentContext!).pushReplacement(
          MaterialPageRoute(builder: (_) => const COACHIKOFollowApp()));
    });
  }
}
