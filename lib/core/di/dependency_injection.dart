import 'package:dio/dio.dart';
import 'package:followupapprefactored/features/auth/login/data/repository/login_repo_impl.dart';
import 'package:followupapprefactored/features/modules/coach/all_clients_display/data/repository/clients_repo_impl.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/login/logic/cubit/login_cubit.dart';
import '../../features/modules/client/diet/data/repository/diet_repo_impl.dart';
import '../../features/modules/client/phases_cases/waiting_phase/data/repository/current_state_repo_impl.dart';
import '../../features/modules/client/routine/routine_get/data/repository/routine_repo_impl.dart';
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
}
