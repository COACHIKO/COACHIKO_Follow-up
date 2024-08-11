import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:followupapprefactored/core/utils/constants/colors.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:followupapprefactored/features/modules/client/diet/logic/cubit/diet_cubit.dart';
import 'package:followupapprefactored/features/modules/client/diet/ui/diet_plan.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/logic/cubit/routine_cubit.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/ui/workout_plan_page.dart';
import 'package:followupapprefactored/features/modules/coach/all_clients_display/logic/cubit/clients_cubit.dart';
import 'package:followupapprefactored/features/modules/coach/all_clients_display/ui/all_clients_display.dart';
import 'package:followupapprefactored/core/utils/helpers/helper_functions.dart';
import 'package:followupapprefactored/core/localization/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../../../view/screens/setting_page.dart';
import '../../../client/diet/data/repository/diet_repo_impl.dart';
import '../../../client/routine/routine_get/data/repository/routine_repo_impl.dart';
import '../../all_clients_display/data/repository/clients_repo_impl.dart';
import '../cubit/coach_navigation_bar_cubit.dart';
import '../cubit/coach_navigation_bar_state.dart';

class CoachNavigationBar extends StatelessWidget {
  final int initialIndex;

  const CoachNavigationBar({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    final screens = [
      _buildWorkoutPlanPage(),
      _buildDietPlanPage(),
      _buildClientsPage(),
      const SettingScreen(),
    ];

    return BlocProvider(
      create: (_) => CoachHomeCubit(initialIndex: initialIndex),
      child: Scaffold(
        body: BlocBuilder<CoachHomeCubit, CoachHomeState>(
          builder: (context, state) {
            return screens[state.selectedIndex];
          },
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
                  label: AppLocalizations.of(context).translate('workout'),
                ),
                NavigationDestination(
                  icon: const Icon(FlutterIcons.food_apple_outline_mco),
                  label: AppLocalizations.of(context).translate('diet'),
                ),
                NavigationDestination(
                  icon: const Icon(Iconsax.people),
                  label: AppLocalizations.of(context).translate('clients'),
                ),
                NavigationDestination(
                  icon: const Icon(Iconsax.user),
                  label: AppLocalizations.of(context).translate('settings'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildWorkoutPlanPage() {
    return BlocProvider(
      create: (_) =>
          RoutineCubit(routineRepoImp: GetIt.instance<RoutineRepoImp>())
            ..getRoutine(),
      child: const WorkoutPlanPage(),
    );
  }

  Widget _buildDietPlanPage() {
    return BlocProvider(
      create: (_) =>
          DietCubit(dietRepoImp: GetIt.instance<DietRepoImp>())..getDietData(),
      child: const DietPlanPage(),
    );
  }

  Widget _buildClientsPage() {
    return BlocProvider(
      create: (_) =>
          ClientsCubit(clientsRepoImp: GetIt.instance<ClientsDataRepoImp>())
            ..getAllClientsData(),
      child: const MyClients(),
    );
  }
}
