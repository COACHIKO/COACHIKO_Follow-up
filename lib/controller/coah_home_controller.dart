import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controller/api_controller.dart';
import '../controller/diet_make_controller.dart';
import '../controller/diet_preview_controller.dart';
import '../view/screens/client_area/workout_plan_page.dart';
import '../view/screens/coach_area/all_coach_clients.dart';
import '../view/screens/coach_area/diet_preview_f_client.dart';

class CoachHomeController extends GetxController {
  static CoachHomeController get instance => Get.find();
  final Rx<int> selectedIndex = 0.obs;
  final ApiController controller = Get.put(ApiController());
  final DietDataController dietDataController = Get.put(DietDataController());
  final DietMakingController dietMakingController = Get.put(DietMakingController());

  final screens = [
      WorkoutPlanPage(),
    const DietPreviewfClient(),
    AllClientsDisplay(),
    const DietPreviewfClient(),
  ];

  @override
  void onInit() {
    super.onInit();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      await controller.fetchRoutineData();
      await dietDataController.fetchData();
      await controller.getCoachClients();
      await controller.getFoodData();
      dietMakingController.filteredFoodList.assignAll(dietMakingController.foodList);
    } catch (e) {
      Fluttertoast.showToast(
        msg: '$e',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
