import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:followupapprefactored/features/modules/client/phases_cases/waiting_phase/data/repository/current_state_repo_impl.dart';
import 'package:followupapprefactored/view/screens/fork_usering_page.dart';
import 'package:get/get.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/services/services.dart';
import 'core/utils/constants/text_strings.dart';
import 'core/utils/theme/theme.dart';
import 'features/auth/login/ui/login_screen.dart';
import 'features/auth/signup/ui/signup_screen.dart';
import 'features/modules/client/navigation_bar/ui/client_navigation_bar.dart';
import 'features/modules/client/phases_cases/form_completion/ui/form_completion.dart';
import 'features/modules/client/phases_cases/waiting_phase/logic/cubit/current_stage_cubit.dart';
import 'features/modules/client/phases_cases/waiting_phase/ui/current_stage_page.dart';
import 'features/modules/coach/navigation_bar/ui/coach_navigation_bar.dart';
import 'firebase_options.dart';

LocaleController localeController = LocaleController();
final myServices = Get.put(MyServices());
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await initialServices();
  runApp(COACHIKOFollowApp());
}

class COACHIKOFollowApp extends StatelessWidget {
  COACHIKOFollowApp({super.key});
  final LocaleController langController = Get.put(LocaleController());
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return GetMaterialApp(
          title: CTexts.appName,
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          locale: langController.language,
          translations: MyTranslation(),
          initialRoute: initialRoute,
          routes: allAppRoutes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

Map<String, Widget Function(BuildContext)> allAppRoutes = {
  "/forkUsering": (context) => const ForkUseringPage(),
  "/signup": (context) => const SignUpPage(),
  "/login": (context) => LoginPage(),
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

String? initialRoute = myServices.sharedPreferences.getInt("user") == null ||
        myServices.sharedPreferences.getBool("rememberMe") == false
    ? "/forkUsering"
    : myServices.sharedPreferences.getInt("isCoach") == 1
        ? "/CoachHome"
        : (myServices.sharedPreferences.getInt("isCoach") == 0 &&
                myServices.sharedPreferences.getInt("currentStep") == 0)
            ? "/formComplection"
            : myServices.sharedPreferences.getInt("currentStep") == 1
                ? "/currentStage"
                : "/ClientHome";
