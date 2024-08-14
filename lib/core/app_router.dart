import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:followupapprefactored/features/modules/client/phases_cases/form_completion/ui/form_completion.dart';
import 'package:followupapprefactored/features/modules/coach/diet_making_features/food_selection/logic/cubit/food_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/login/ui/login_screen.dart';
import '../features/auth/signup/ui/signup_screen.dart';
import '../features/modules/client/diet/data/models/diet_response.dart';
import '../features/modules/client/diet/ui/diet_plan.dart';
import '../features/modules/client/navigation_bar/ui/client_navigation_bar.dart';
import '../features/modules/client/phases_cases/waiting_phase/data/repository/current_state_repo_impl.dart';
import '../features/modules/client/phases_cases/waiting_phase/logic/cubit/current_stage_cubit.dart';
import '../features/modules/client/phases_cases/waiting_phase/ui/current_stage_page.dart';
import '../features/modules/client/routine/routine_get/data/models/routine_response.dart';
import '../features/modules/client/routine/routine_log/ui/routine_weight_log.dart';
import '../features/modules/coach/navigation_bar/ui/coach_navigation_bar.dart';
import '../view/screens/fork_usering_page.dart';
import 'di/dependency_injection.dart';
import 'services/shared_pref/shared_pref.dart';

class AppRouter {
  late GoRouter router;

  AppRouter() {
    _initializeRouter();
  }

  Future<void> _initializeRouter() async {
    final initialRoute = await _determineInitialRoute();

    router = GoRouter(
      initialLocation: initialRoute,
      routes: _buildRoutes(),
      errorBuilder: (context, state) => const ForkUseringPage(),
    );
  }

  List<GoRoute> _buildRoutes() {
    return [
      GoRoute(
        path: Routes.forkUsering,
        builder: (context, state) => const ForkUseringPage(),
      ),
      GoRoute(
        path: Routes.signUpScreen,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: Routes.loginScreen,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.formComplection,
        builder: (context, state) => const FormComplectionView(),
      ),
      GoRoute(
        path: Routes.currentStage,
        builder: (context, state) => BlocProvider(
          create: (context) => CurrentStageCubit(
              currentStateRepoImpl: sl<CurrentStateRepoImpl>())
            ..getCurrentStage(),
          child: const CurrentStage(),
        ),
      ),
      GoRoute(
        path: Routes.clientHome,
        builder: (context, state) => const ClientNavigationBar(),
      ),
      GoRoute(
        path: Routes.coachHome,
        builder: (context, state) => const CoachNavigationBar(),
      ),
      GoRoute(
        path: Routes.routineLog,
        builder: (context, state) {
          final routine = state.extra as Routine;
          return RoutineWeightLogScreen(routine: routine);
        },
      ),
      GoRoute(
        path: Routes.dietExchange,
        builder: (context, state) {
          final dietList = state.extra as List<DietItem>;
          return BlocProvider(
            create: (context) => sl<FoodCubit>()..getFoods(),
            child: ConvertFooods(
              diet: dietList,
            ),
          );
        },
      )
    ];
  }

  Future<String> _determineInitialRoute() async {
    final sharedPref = GetIt.instance<SharedPref>();
    final userType = sharedPref.getInt("user");
    final rememberMe = sharedPref.getBool("rememberMe");
    final isCoach = sharedPref.getInt("isCoach");
    final currentStep = sharedPref.getInt("currentStep");

    if (userType == null || rememberMe == false) {
      return Routes.forkUsering;
    } else if (isCoach == 1) {
      return Routes.coachHome;
    } else if (isCoach == 0 && currentStep == 0) {
      return Routes.formComplection;
    } else if (currentStep == 1) {
      return Routes.currentStage;
    } else {
      return Routes.clientHome;
    }
  }
}

class Routes {
  static const String forkUsering = '/fork';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/signup';
  static const String formComplection = '/formComplection';
  static const String currentStage = '/currentStage';
  static const String coachHome = '/coachHome';
  static const String clientHome = '/clientHome';
  static const String routineLog = '/routineLog';
  static const String dietExchange = '/dietExchange';
}
