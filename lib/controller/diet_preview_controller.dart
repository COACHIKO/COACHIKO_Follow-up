import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../data/model/food_model.dart';
import 'api_controller.dart';
import 'diet_make_controller.dart';

class DietDataController extends GetxController {
  final ApiController _apiController = Get.put(ApiController());
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
      await _apiController.dietGetForClient();
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
