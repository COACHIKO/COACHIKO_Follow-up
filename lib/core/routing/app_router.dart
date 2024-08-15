import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:followupapprefactored/core/routing/routes.dart';
import 'package:followupapprefactored/features/modules/client/phases_cases/form_completion/ui/form_completion.dart';
import 'package:followupapprefactored/features/modules/coach/diet_making_features/food_selection/logic/cubit/food_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login/ui/login_screen.dart';
import '../../features/auth/signup/ui/signup_screen.dart';
import '../../features/client_log_history/logic/cubit/log_history_cubit.dart';
import '../../features/client_log_history/ui/logs_history.dart';
import '../../features/modules/client/diet/data/models/diet_response.dart';
import '../../features/modules/client/diet/ui/diet_plan.dart';
import '../../features/modules/client/navigation_bar/ui/client_navigation_bar.dart';
import '../../features/modules/client/phases_cases/waiting_phase/data/repository/current_state_repo_impl.dart';
import '../../features/modules/client/phases_cases/waiting_phase/logic/cubit/current_stage_cubit.dart';
import '../../features/modules/client/phases_cases/waiting_phase/ui/current_stage_page.dart';
import '../../features/modules/client/routine/routine_get/data/models/routine_response.dart';
import '../../features/modules/client/routine/routine_log/ui/routine_weight_log.dart';
import '../../features/modules/coach/all_clients_display/data/models/clients_response.dart';
import '../../features/modules/coach/diet_making_features/food_selection/ui/food_selection_page.dart';
import '../../features/modules/coach/diet_making_features/quantities_entering/data/repository/food_quantities_repo_imp.dart';
import '../../features/modules/coach/diet_making_features/quantities_entering/logic/cubit/food_quantities_cubit.dart';
import '../../features/modules/coach/diet_making_features/quantities_entering/ui/food_quantities_insertion.dart';
import '../../features/modules/coach/navigation_bar/ui/coach_navigation_bar.dart';
import '../../features/modules/coach/specific_client_profile/ui/client_profile_page.dart';
import '../../features/modules/coach/workout_routine_making_features/display_client_routine/logic/cubit/client_routines_cubit.dart';
import '../../features/modules/coach/workout_routine_making_features/display_client_routine/ui/client_routines_display.dart';
import '../../features/modules/coach/workout_routine_making_features/exercises_selection/data/repository/exercises_repo_impl.dart';
import '../../features/modules/coach/workout_routine_making_features/exercises_selection/logic/cubit/exercises_cubit.dart';
import '../../features/modules/coach/workout_routine_making_features/exercises_selection/ui/exercises_selection_page.dart';
import '../../features/modules/coach/workout_routine_making_features/quantities_entering/data/repository/exercises_assignment_repo_imp.dart';
import '../../features/modules/coach/workout_routine_making_features/quantities_entering/logic/cubit/exercises_assignment_cubit.dart';
import '../../features/modules/coach/workout_routine_making_features/quantities_entering/ui/exercises_assignment_to_routine.dart';
import '../../view/screens/fork_usering_page.dart';
import '../di/dependency_injection.dart';
import '../services/shared_pref/shared_pref.dart';
import 'routing_model/routing_model.dart';

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
      ),
      GoRoute(
        path: Routes.clientProfile,
        builder: (context, state) {
          final clientData = state.extra as ClientData;
          return ClientProfilePage(clientData: clientData);
        },
      ),
      GoRoute(
        path: Routes.trackHistory,
        builder: (context, state) {
          final params = state.extra as TrackHistoryParams;
          return BlocProvider(
            create: (context) =>
                sl<LogHistoryCubit>()..getLogsHistory(params.userId),
            child: LogsHistoryPage(
              name: params.name,
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.foodSelection,
        builder: (context, state) {
          final clientData = state.extra as ClientData;
          return BlocProvider(
              create: (context) => sl<FoodCubit>()..getFoods(),
              child: FoodSelection(clientData: clientData));
        },
      ),
      GoRoute(
        path: Routes.clientRoutines,
        builder: (context, state) {
          final clientData = state.extra as ClientData;
          return BlocProvider(
            create: (context) =>
                sl<ClientRoutinsCubit>()..getRoutine(clientData.id),
            child: ClientRoutineDisplay(clientData: clientData),
          );
        },
      ),
      GoRoute(
          path: Routes.quantitiesEntering,
          builder: (context, state) {
            final params = state.extra as SelectedFoodsParams;
            return BlocProvider(
                create: (context) => FoodQuantitiesCubit(
                    foodQuantitiesRepoImp: sl<FoodQuantitiesRepoImp>(),
                    lenth: params.selectedFoods.length),
                child: FoodQuantitiesEntering(
                    selectedFoods: params.selectedFoods,
                    clientData: params.clientData));
          }),
      GoRoute(
        path: Routes.exercisesAssignment,
        builder: (context, state) {
          final params = state.extra as ExerciseAssignmentParams;
          return BlocProvider(
            create: (context) => ExerciseAssignmentCubit(
              clientData: params.clientData,
              routine: params.routine,
              selectedExercises: params.oldExercises,
              exercisesAssignmentRepoImp: sl<ExercisesAssignmentRepoImp>(),
            ),
            child: const Exercisesassignment(),
          );
        },
      ),
      GoRoute(
        path: Routes.exerciseSelection,
        builder: (context, state) {
          final params = state.extra as ExerciseSelectionParams;
          return BlocProvider(
            create: (context) => SelectingExercisesCubit(
                lastSelectedExercises: params.oldExercises,
                exercisesRepoimpl: sl<SelectingExercisesRepoImpl>())
              ..getFoods(),
            child: ExercisesSelection(
              clientData: params.clientData,
              routine: params.routine,
            ),
          );
        },
      ),
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
