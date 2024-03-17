import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../data/model/diet_models/food_model.dart';
import '../../../data/source/web_services/client_web_services/client_diet_get_service.dart';
import '../../coach_controllers/diet_making_controllers/diet_make_controller.dart';

class DietDataController extends GetxController {
  ClientDietGet clientDietGet = ClientDietGet();
   final DietMakingController _dietMakingController = Get.put(DietMakingController());
  RxBool isLoading = true.obs;
  RxList<DietData> dietData = <DietData>[].obs;
  @override
  void onInit() {
    super.onInit();
    if (isLoading.isTrue) {
      fetchData();
    }
  }
  Future<void> fetchData() async {
    try {
      await clientDietGet.dietGetForClient();
      dietData.assignAll(_dietMakingController.dietData);
      isLoading.value = false;
    } catch (e) {
      Fluttertoast.showToast(
        msg: '$e',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      isLoading.value = false;
    }
  }
}
