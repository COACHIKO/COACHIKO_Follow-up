import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../../../controller/coach_controllers/diet_making_controllers/diet_make_controller.dart';
import '../../../../../linkapi.dart';
 import '../../../../model/diet_models/food_model.dart';
final dietMakingController = Get.put(DietMakingController());

class FoodDataBase{
  Future<void> getFoodData() async {
    final response = await http.get(Uri.parse(AppLink.getDietDataAPI));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      dietMakingController.foodList = data.map((item) => FoodDataModel.fromJson(item)).toList();
      dietMakingController.filteredFoodList.assignAll(dietMakingController.foodList);

    } else {}
  }
}