import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../data/model/client_user_model.dart';
import '../data/model/food_model.dart';

class DietMakingController extends GetxController {
  static DietMakingController get instance => Get.find();
  List<ClientUser> coachClients = [];
  List<FoodDataModel> foodList = [];
  List<DietData> dietData = [];
  RxList<FoodDataModel> filteredFoodList = <FoodDataModel>[].obs;
  RxList<int> selectedIndexes = <int>[].obs;
  RxList<DietModel> selectedDietList = <DietModel>[].obs;
  late TextEditingController search;
  @override
  void onInit() {
    super.onInit();
    search = TextEditingController();
  }
  @override
  void onClose() {
    search.dispose();
    super.onClose();
  }
  void filterFoodList(String query) {
    filteredFoodList.assignAll(foodList
        .where((food) => food.foodName.toLowerCase().contains(query.toLowerCase()))
        .toList());
    update(); // Update UI after filtering
  }
  void toggleSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
      selectedDietList.removeWhere((diet) => diet.foodData.id == filteredFoodList[index].id);
    } else {
      selectedIndexes.add(index);
      DietModel newDiet = DietModel(
        foodData: filteredFoodList[index],
        quantity: 1,
      );
      selectedDietList.add(newDiet);
    }
    update(); // Update UI after toggling selection
  }
  void addToDietList() {
    for (int index in selectedIndexes) {
      DietModel newDiet = DietModel(
        foodData: filteredFoodList[index],
        quantity: 1,
      );

      int existingIndex = selectedDietList.indexWhere((diet) => diet.foodData.id == newDiet.foodData.id);

      if (existingIndex != -1) {
        selectedDietList[existingIndex].quantity += newDiet.quantity;
      } else {
        selectedDietList.add(newDiet);
      }
    }

    selectedIndexes.clear();

    Fluttertoast.showToast(
      msg: 'Added to diet list!',
      backgroundColor: Colors.green,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );

    update(); // Update UI after adding to diet list
  }
}
