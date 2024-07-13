import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:followupapprefactored/core/utils/constants/colors.dart';
import 'package:followupapprefactored/features/client_log_history/data/repository/get_log_history_repo_imp.dart';
import 'package:followupapprefactored/features/client_log_history/ui/logs_history.dart';
import 'package:followupapprefactored/main.dart';
import 'package:get/get.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dio/dio.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:followupapprefactored/features/modules/client/diet/data/repository/diet_repo_impl.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/repository/routine_repo_impl.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/ui/workout_plan_page.dart';
import 'package:followupapprefactored/features/modules/client/diet/logic/cubit/diet_cubit.dart';
import 'package:followupapprefactored/features/modules/client/diet/ui/diet_plan.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/logic/cubit/routine_cubit.dart';
import 'package:followupapprefactored/view/screens/setting_page.dart';
import 'package:followupapprefactored/core/utils/helpers/helper_functions.dart';

import '../../../../client_log_history/logic/cubit/log_history_cubit.dart';
import '../logic/cubit/client_navigation_bar_cubit.dart';
import '../logic/cubit/client_navigation_bar_state.dart';

class ClientNavigationBar extends StatelessWidget {
  final int initialIndex;

  const ClientNavigationBar({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    final screens = [
      BlocProvider(
          create: (context) {
            return LogHistoryCubit(
                getLogHistoryRepoImp: GetLogHistoryRepoImp(ApiService(Dio())))
              ..getLogsHistory(myServices.sharedPreferences.getInt("user"));
          },
          child: LogsHistoryPage(
            name:
                myServices.sharedPreferences.getString("first_name").toString(),
          )),
      BlocProvider(
          create: (context) {
            return RoutineCubit(
                routineRepoImp: RoutineRepoImp(ApiService(Dio())))
              ..getRoutine();
          },
          child: const WorkoutPlanPage()),
      BlocProvider(
          create: (context) {
            return DietCubit(dietRepoImp: DietRepoImp(ApiService(Dio())))
              ..getDietData();
          },
          child: const DietPlanPage()),
      const SettingScreen(),
    ];

    return BlocProvider(
      create: (_) => ClientNavigationBarCubit(initialIndex: initialIndex),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 300));
          },
          child:
              BlocBuilder<ClientNavigationBarCubit, ClientNavigationBarState>(
            builder: (context, state) {
              return screens[state.selectedIndex];
            },
          ),
        ),
        bottomNavigationBar:
            BlocBuilder<ClientNavigationBarCubit, ClientNavigationBarState>(
          builder: (context, state) {
            return NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: state.selectedIndex,
              onDestinationSelected: (index) {
                context.read<ClientNavigationBarCubit>().changeTabIndex(index);
              },
              backgroundColor: darkMode ? CColors.black : Colors.white,
              indicatorColor: darkMode
                  ? CColors.white.withOpacity(0.1)
                  : CColors.black.withOpacity(0.1),
              destinations: [
                NavigationDestination(
                  icon: const Icon(
                    FlutterIcons.dumbbell_faw5s,
                    size: 22,
                  ),
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
