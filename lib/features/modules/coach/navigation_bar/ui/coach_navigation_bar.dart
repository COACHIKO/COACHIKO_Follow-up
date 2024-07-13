import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:followupapprefactored/core/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dio/dio.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:followupapprefactored/features/modules/client/diet/data/repository/diet_repo_impl.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/repository/routine_repo_impl.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/ui/workout_plan_page.dart';
import 'package:followupapprefactored/features/modules/coach/all_clients_display/data/repository/clients_repo_impl.dart';
import 'package:followupapprefactored/features/modules/client/diet/logic/cubit/diet_cubit.dart';
import 'package:followupapprefactored/features/modules/client/diet/ui/diet_plan.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/logic/cubit/routine_cubit.dart';
import 'package:followupapprefactored/features/modules/coach/all_clients_display/logic/cubit/clients_cubit.dart';
import 'package:followupapprefactored/features/modules/coach/all_clients_display/ui/all_clients_display.dart';
import 'package:followupapprefactored/core/utils/helpers/helper_functions.dart';
import '../../../../../view/screens/setting_page.dart';
import '../cubit/coach_navigation_bar_cubit.dart';
import '../cubit/coach_navigation_bar_state.dart';

class CoachNavigationBar extends StatelessWidget {
  final int initialIndex;

  const CoachNavigationBar({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    final screens = [
      BlocProvider(
        create: (context) {
          return RoutineCubit(routineRepoImp: RoutineRepoImp(ApiService(Dio())))
            ..getRoutine();
        },
        child: const WorkoutPlanPage(),
      ),
      BlocProvider(
        create: (context) {
          return DietCubit(dietRepoImp: DietRepoImp(ApiService(Dio())))
            ..getDietData();
        },
        child: const DietPlanPage(),
      ),
      BlocProvider(
        create: (context) {
          return ClientsCubit(
              clientsRepoImp: ClientsDataRepoImp(ApiService(Dio())))
            ..getAllClientsData();
        },
        child: const MyClients(),
      ),
      const SettingScreen(),
    ];

    return BlocProvider(
      create: (_) => CoachHomeCubit(initialIndex: initialIndex),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 300));
          },
          child: BlocBuilder<CoachHomeCubit, CoachHomeState>(
            builder: (context, state) {
              return screens[state.selectedIndex];
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<CoachHomeCubit, CoachHomeState>(
          builder: (context, state) {
            return NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: state.selectedIndex,
              onDestinationSelected: (index) {
                context.read<CoachHomeCubit>().changeTabIndex(index);
              },
              backgroundColor: darkMode ? CColors.black : Colors.white,
              indicatorColor: darkMode
                  ? CColors.white.withOpacity(0.1)
                  : CColors.black.withOpacity(0.1),
              destinations: [
                NavigationDestination(
                  icon: const Icon(FlutterIcons.dumbbell_faw5s, size: 22),
                  label: "47".tr,
                ),
                NavigationDestination(
                  icon: const Icon(FlutterIcons.food_apple_outline_mco),
                  label: "54".tr,
                ),
                NavigationDestination(
                  icon: const Icon(Iconsax.people),
                  label: "51".tr,
                ),
                NavigationDestination(
                  icon: const Icon(Iconsax.user),
                  label: "50".tr,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
