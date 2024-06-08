import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:followupapprefactored/features/modules/client/diet/data/repository/diet_repo_impl.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/repository/routine_repo_impl.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/ui/workout_plan_page.dart';
import 'package:followupapprefactored/features/modules/coach/all_clients_display/data/repository/clients_repo_impl.dart';
import 'package:get/get.dart';
import '../../features/modules/client/diet/logic/cubit/diet_cubit.dart';
import '../../features/modules/client/diet/ui/diet_plan.dart';
import '../../features/modules/client/routine/routine_get/logic/cubit/routine_cubit.dart';
import '../../features/modules/coach/all_clients_display/logic/cubit/clients_cubit.dart';
import '../../features/modules/coach/all_clients_display/ui/all_clients_display.dart';
import '../../view/screens/setting_page.dart';

class CoachHomeController extends GetxController {
  static CoachHomeController get instance => Get.find();
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    BlocProvider(
      create: (context) =>
          RoutineCubit(routineRepoImp: RoutineRepoImp(ApiService(Dio())))
            ..getRoutine(),
      child: const WorkoutPlanPage(),
    ),
    BlocProvider(
      create: (context) =>
          DietCubit(dietRepoImp: DietRepoImp(ApiService(Dio())))..getDietData(),
      child: const DietPlanPage(),
    ),
    BlocProvider(
      create: (context) =>
          ClientsCubit(clientsRepoImp: ClientsDataRepoImp(ApiService(Dio())))
            ..getAllClientsData(),
      child: const MyClients(),
    ),
    const SettingScreen(),
  ];
}
