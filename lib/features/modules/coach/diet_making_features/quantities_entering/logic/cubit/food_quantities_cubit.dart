import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../food_selection/data/models/food_model.dart';
import '../../data/models/quantity_insertion_request_body.dart';
import '../../data/repository/food_quantities_repo_imp.dart';
import 'food_quantities_state.dart';

class FoodQuantitiesCubit extends Cubit<FoodQuantitiesStates> {
  final FoodQuantitiesRepoImp foodQuantitiesRepoImp;
  final int lenth;
  List<TextEditingController> controllers = [];

  FoodQuantitiesCubit({
    required this.foodQuantitiesRepoImp,
    required this.lenth,
  }) : super(FoodQuantitiesInitialState()) {
    for (int i = 0; i < lenth; i++) {
      var controller = TextEditingController();
      controller.addListener(() {
        onTextChanged(controller.text, i);
      });
      controllers.add(controller);
    }
  }

  void onTextChanged(String text, int index) {
    // You can add any additional logic here, such as validation
    emit(FoodQuantitiesUpdateState(text, index));
  }

  double calculateTotalCalories(List<FoodDataModel> selectedFoods) {
    double totalCalories = 0;

    for (int i = 0; i < selectedFoods.length; i++) {
      int quantity = int.tryParse(controllers[i].text) ?? 0;
      totalCalories += selectedFoods[i].calories * quantity;
    }

    return totalCalories;
  }

  double calculateTotalProtien(List<FoodDataModel> selectedFoods) {
    double totalProtien = 0;

    for (int i = 0; i < selectedFoods.length; i++) {
      int quantity = int.tryParse(controllers[i].text) ?? 0;
      totalProtien += selectedFoods[i].protein * quantity;
    }

    return totalProtien;
  }

  double calculateTotalCarbohydrate(List<FoodDataModel> selectedFoods) {
    double totalCarbohydrate = 0;

    for (int i = 0; i < selectedFoods.length; i++) {
      int quantity = int.tryParse(controllers[i].text) ?? 0;
      totalCarbohydrate += selectedFoods[i].carbohydrates * quantity;
    }

    return totalCarbohydrate;
  }

  double calculateTotalFat(List<FoodDataModel> selectedFoods) {
    double totalFats = 0;

    for (int i = 0; i < selectedFoods.length; i++) {
      int quantity = int.tryParse(controllers[i].text) ?? 0;
      totalFats += selectedFoods[i].fats * quantity;
    }

    return totalFats;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> enterQuantities(
      QuantityInsertionRequestBody quantityInsertionRequestBody) async {
    try {
      var foods = await foodQuantitiesRepoImp
          .enterQuantites(quantityInsertionRequestBody);
      if (foods.message == "Diet inserted successfully!") {
        showToast(foods.message);
      }
    } catch (e) {
      emit(FoodsStateError(e.toString()));
    }
  }

  Tuple2<String, String> getFoodNamesAndQuantities(selectedFoods) {
    String foodNames = '';
    String quantities = '';

    for (int i = 0; i < selectedFoods.length; i++) {
      if (controllers[i].text != '0' && controllers[i].text.isNotEmpty) {
        // Check if quantity is not zero
        foodNames += '${selectedFoods[i].id}, ';
        quantities += '${controllers[i].text}, ';
      }
    }
    foodNames = foodNames.isNotEmpty
        ? foodNames.substring(0, foodNames.length - 2)
        : '';
    quantities = quantities.isNotEmpty
        ? quantities.substring(0, quantities.length - 2)
        : '';

    return Tuple2(foodNames, quantities);
  }

  TextEditingController getController(int index) {
    return controllers[index];
  }
}
