import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/constants/text_strings.dart';
import 'core/utils/theme/cubit/theme_cubit.dart';
import 'core/utils/theme/theme.dart';
import 'core/localization/app_localizations_setup.dart';
import 'core/localization/cubit/locale_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main.dart';

class COACHIKOFollowApp extends StatelessWidget {
  const COACHIKOFollowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocaleCubit()..getSavedLanguage(),
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, localeState) {
          return BlocProvider(
            create: (context) => ThemeCubit(),
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeState) {
                return ScreenUtilInit(
                  designSize: const Size(360, 690),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (BuildContext context, child) {
                    return MaterialApp(
                      locale: localeState.locale,
                      supportedLocales: AppLocalizationsSetup.supportedLocales,
                      localizationsDelegates:
                          AppLocalizationsSetup.localizationsDelegates,
                      localeResolutionCallback:
                          AppLocalizationsSetup.localeResolutionCallback,
                      navigatorKey: navigatorKey,
                      title: CTexts.appName,
                      themeMode: themeState,
                      theme: TAppTheme.lightTheme,
                      darkTheme: TAppTheme.darkTheme,
                      initialRoute: initialRoute,
                      routes: allAppRoutes,
                      debugShowCheckedModeBanner: false,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
