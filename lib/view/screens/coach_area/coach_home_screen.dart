import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:iconsax/iconsax.dart';
import '../../../controller/coach_controllers/coah_home_controller.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../../core/utils/constants/colors.dart';

class CoachHome extends StatelessWidget {
  const CoachHome({super.key,});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CoachHomeController());

    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate a delay to show loading indicator
          await Future.delayed(const Duration(milliseconds: 300));

          await controller.fetchData();
        },
        child: Obx(
              () => controller.screens[controller.selectedIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(() => NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: (index) =>
        controller.selectedIndex.value = index,
        backgroundColor:
        darkMode ? CColors.black : Colors.white,
        indicatorColor: darkMode
            ? CColors.white.withOpacity(0.1)
            : CColors.black.withOpacity(0.1),
        destinations: [
          NavigationDestination(
            icon:  const Icon(FlutterIcons.dumbbell_faw5s,size: 22,),
            label: "47".tr,
          ),
          NavigationDestination(
            icon:const Icon(FlutterIcons.food_apple_outline_mco),
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
      )),
    );
  }
}
