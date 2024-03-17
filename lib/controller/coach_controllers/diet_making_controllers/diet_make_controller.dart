import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../data/model/client_user_model.dart';
import '../../../data/model/diet_models/food_model.dart';
import '../../../data/source/web_services/databases_web_services/food_data_base/all_foods_database_get_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DietMakingController extends GetxController {
  static DietMakingController get instance => Get.find();
  FoodDataBase foodDataBase = FoodDataBase();
  List<ClientUser> coachClients = [];
  List<FoodDataModel> foodList = [];
  List<DietData> dietData = [];
  RxList<FoodDataModel> filteredFoodList = <FoodDataModel>[].obs;
  RxList<int> selectedIndexes = <int>[].obs;
  RxList<DietModel> selectedDietList = <DietModel>[].obs;
  late TextEditingController search;
  @override
  void onInit() async{
    super.onInit();
   await foodDataBase.getFoodData();
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
  sendMessage(title,message,token)async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAArxpC8tI:APA91bEw_Xt-nUYuI2bOVaNNUliTbg6aaRZi2y6S3X8-dcSyNh4ZiwK8LNl64oaLKZJe-UL2x-86xyWQ16siEDNVeMY_Z-KzSRBZ2hri2lyKVdtX3V8XAmy_QR8jzxxiKseDE64aPXBK'
    };
    var request = http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "to": token,
      "notification": {
        "title": title,
        "body": message,
        "mutable_content": true,
        "sound": "Tri-tone"
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
    }
    else {
      //print(response.reasonPhrase);
    }

  }

}
