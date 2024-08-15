import 'package:dio/dio.dart';
import 'package:followupapprefactored/features/auth/login/data/repository/login_repo_impl.dart';
import 'package:followupapprefactored/features/modules/coach/all_clients_display/data/repository/clients_repo_impl.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/login/logic/cubit/login_cubit.dart';
import '../../features/client_log_history/data/repository/get_log_history_repo_imp.dart';
import '../../features/client_log_history/logic/cubit/log_history_cubit.dart';
import '../../features/modules/client/diet/data/repository/diet_repo_impl.dart';
import '../../features/modules/client/phases_cases/waiting_phase/data/repository/current_state_repo_impl.dart';
import '../../features/modules/client/routine/routine_get/data/repository/routine_repo_impl.dart';
import '../../features/modules/coach/diet_making_features/food_selection/data/repository/foods_repo_impl.dart';
import '../../features/modules/coach/diet_making_features/food_selection/logic/cubit/food_cubit.dart';
import '../../features/modules/coach/diet_making_features/quantities_entering/data/repository/food_quantities_repo_imp.dart';
import '../../features/modules/coach/diet_making_features/quantities_entering/logic/cubit/food_quantities_cubit.dart';
import '../../features/modules/coach/workout_routine_making_features/display_client_routine/data/repository/client_routines_repo_impl.dart';
import '../../features/modules/coach/workout_routine_making_features/display_client_routine/logic/cubit/client_routines_cubit.dart';
import '../../features/modules/coach/workout_routine_making_features/exercises_selection/data/repository/exercises_repo_impl.dart';
import '../../features/modules/coach/workout_routine_making_features/quantities_entering/data/repository/exercises_assignment_repo_imp.dart';
import '../networking/api_service.dart';
import '../services/shared_pref/shared_pref.dart';

final GetIt sl = GetIt.instance;

Future<void> setupInjector() async {
  sl.registerLazySingleton(() => ApiService(Dio()));

  sl.registerLazySingleton(() => CurrentStateRepoImpl(sl()));
  sl.registerLazySingleton(() => RoutineRepoImp(sl()));
  sl.registerLazySingleton(() => DietRepoImp(sl()));
  sl.registerSingleton<SharedPref>(SharedPref());
  sl.registerLazySingleton<ClientsDataRepoImp>(
      () => ClientsDataRepoImp(sl<ApiService>()));
  sl.registerLazySingleton<LoginRepoImp>(() => LoginRepoImp(sl<ApiService>()));
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit(sl<LoginRepoImp>()));
  sl.registerLazySingleton<FoodsRepoImpl>(
      () => FoodsRepoImpl(sl<ApiService>()));
  sl.registerFactory<FoodCubit>(
      () => FoodCubit(foodsRepoImpl: sl<FoodsRepoImpl>(), selectedfoods: []));

  sl.registerLazySingleton<GetLogHistoryRepoImp>(
      () => GetLogHistoryRepoImp(sl<ApiService>()));
  sl.registerFactory<LogHistoryCubit>(
      () => LogHistoryCubit(getLogHistoryRepoImp: sl<GetLogHistoryRepoImp>()));

  sl.registerLazySingleton<FoodQuantitiesRepoImp>(
      () => FoodQuantitiesRepoImp(sl<ApiService>()));
  sl.registerFactory<FoodQuantitiesCubit>(() => FoodQuantitiesCubit(
      foodQuantitiesRepoImp: sl<FoodQuantitiesRepoImp>(), lenth: 0));

  sl.registerLazySingleton<ClientRoutinesRepoImp>(
      () => ClientRoutinesRepoImp(sl<ApiService>()));
  sl.registerFactory<ClientRoutinsCubit>(() =>
      ClientRoutinsCubit(clientRoutinesRepoImp: sl<ClientRoutinesRepoImp>()));
  sl.registerLazySingleton<ExercisesAssignmentRepoImp>(
      () => ExercisesAssignmentRepoImp(sl<ApiService>()));
  sl.registerLazySingleton<SelectingExercisesRepoImpl>(
      () => SelectingExercisesRepoImpl(sl<ApiService>()));
}
