import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'coachiko_app.dart';
import 'core/services/services.dart';
import 'core/services/shared_pref/shared_pref.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
