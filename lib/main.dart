import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'core/localization/app_localizations_setup.dart';
import 'core/localization/cubit/locale_cubit.dart';
import 'core/services/services.dart';
import 'core/services/shared_pref/shared_pref.dart';
import 'core/utils/constants/text_strings.dart';
import 'core/utils/theme/cubit/theme_cubit.dart';
import 'core/utils/theme/theme.dart';
import 'features/auth/login/ui/login_screen.dart';
import 'features/auth/signup/ui/signup_screen.dart';
import 'features/modules/client/navigation_bar/ui/client_navigation_bar.dart';
import 'features/modules/client/phases_cases/form_completion/ui/form_completion.dart';
import 'features/modules/client/phases_cases/waiting_phase/data/repository/current_state_repo_impl.dart';
import 'features/modules/client/phases_cases/waiting_phase/logic/cubit/current_stage_cubit.dart';
import 'features/modules/client/phases_cases/waiting_phase/ui/current_stage_page.dart';
import 'features/modules/coach/navigation_bar/ui/coach_navigation_bar.dart';
import 'firebase_options.dart';
import 'view/screens/fork_usering_page.dart';

final SharedPref sharedPref = SharedPref();

// final myServices = MyServices();
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref().instantiatePreferences();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await initialServices();
  runApp(const COACHIKOFollowApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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

Map<String, Widget Function(BuildContext)> allAppRoutes = {
  "/forkUsering": (context) => const ForkUseringPage(),
  "/signup": (context) => const SignUpPage(),
  "/login": (context) => const LoginPage(),
  "/formComplection": (context) => const FormComplectionView(),
  "/currentStage": (context) => BlocProvider(
        create: (context) => CurrentStageCubit(
            currentStateRepoImpl: CurrentStateRepoImpl(ApiService(Dio())))
          ..getCurrentStage(),
        child: const CurrentStage(),
      ),
  "/ClientHome": (context) => const ClientNavigationBar(),
  "/CoachHome": (context) => const CoachNavigationBar(),
};

String? initialRoute = SharedPref().getInt("user") == null ||
        SharedPref().getBool("rememberMe") == false
    ? "/forkUsering"
    : SharedPref().getInt("isCoach") == 1
        ? "/CoachHome"
        : (SharedPref().getInt("isCoach") == 0 &&
                SharedPref().getInt("currentStep") == 0)
            ? "/formComplection"
            : SharedPref().getInt("currentStep") == 1
                ? "/currentStage"
                : "/ClientHome";
