import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../coach/diet_making_features/food_selection/data/models/food_model.dart';
import '../../data/models/form_completion_request_body.dart';
import '../../data/repository/form_completion_repo_imp.dart';
import 'form_completion_state.dart';

class FormCompletionCubit extends Cubit<FormComplectionStates> {
  final FormCompletionRepoImp formCompletionRepoImp;

  FormCompletionCubit({required this.formCompletionRepoImp})
      : super(FoodQuantitiesInitialState());

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

  final controller = PageController();

  /// Gender Selection
  bool isSelectedMan = false;
  bool isSelectedWoMan = false;
  bool gender = false; //true is man //false woman

  /// Goal Selection
  bool isSelectedLoseWeight = false;
  bool isSelectedGainWeight = false;
  bool isSelectedMaintainWeight = false;

  /// Activity Selection
  bool isLowActivitySelected = false;
  bool isLightActivitySelected = false;
  bool isModerateActivitySelected = false;
  bool isHeavyActivitySelected = false;
  bool isExtreemActivitySelected = false;
  double activityFactor = 0.0;

  /// Age Calculating
  int age = 0;
  DateTime currentDate = DateTime.now();
  DateTime birthdayDate = DateTime(1950, 1, 1);

  /// TALL AND WEIGHT

  TextEditingController weight = TextEditingController();
  TextEditingController tall = TextEditingController();
  TextEditingController waist = TextEditingController();
  TextEditingController neck = TextEditingController();
  TextEditingController arms = TextEditingController();
  TextEditingController calves = TextEditingController();
  TextEditingController hip = TextEditingController();
  TextEditingController chest = TextEditingController();
  TextEditingController wrist = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var womanFormKey = GlobalKey<FormState>();

  /// BODY MESUREMENT

  ///  BODY COMPOSTION
  double fatPercentage = 0;
  double fatWeight = 0;
  double leanBodyMass = 0;

  ///  TARGET GOAL
  late bool wheightloss = isSelectedLoseWeight;

  late bool wheightgain = isSelectedGainWeight;

  late bool weightMaintain = isSelectedMaintainWeight;

  /// DIET MONEY FACTOR
  bool poorMoney = false;

  bool mediumMoney = false;

  bool richMoney = false;

  /// BODY NEEDS
  late double minProtienValue = leanBodyMass * 1;
  double targetProtein = 0;
  double targetCarbs = 0;
  double targetFat = 0;
  double basalMetabolicRate = 0;
  double totalDailyEnergyExpenditure = 0;
  List<FoodDataModel> selectedFoods = [];

  /// Selected FOODS

  ///                                      VARIABLE LAND ENDS HERE                                                     ///

  ///                                      FUNCTION LAND STARTS HERE                                                     ///

  /// GENDER SELECT
  void womanSelected() {
    isSelectedMan = false;
    isSelectedWoMan = true;

    if (isSelectedMan == false) {
      gender = false;
      emit(UpdateState());
    }
  }

  void manSelected() {
    isSelectedWoMan = false;
    isSelectedMan = true;

    if (isSelectedMan == true) {
      gender = true;
    }
    emit(UpdateState());
  }

  /// Goal Selection Function
  void loseWeightSelected() {
    isSelectedLoseWeight = true;
    isSelectedGainWeight = false;
    isSelectedMaintainWeight = false;
    emit(UpdateState());
  }

  void gainWeightSelected() {
    isSelectedGainWeight = true;
    isSelectedLoseWeight = false;
    isSelectedMaintainWeight = false;
    emit(UpdateState());
  }

  void maintainWeightSelected() {
    isSelectedMaintainWeight = true;
    isSelectedGainWeight = false;
    isSelectedLoseWeight = false;
    emit(UpdateState());
  }

  /// Activity Selection Function
  void isLowActivitySelectedFunction() {
    isLowActivitySelected = true;
    isLightActivitySelected = false;
    isModerateActivitySelected = false;
    isHeavyActivitySelected = false;
    isExtreemActivitySelected = false;
    emit(UpdateState());
  }

  void isLightActivitySelectedFunction() {
    isLightActivitySelected = true;
    isModerateActivitySelected = false;
    isHeavyActivitySelected = false;
    isExtreemActivitySelected = false;
    isLowActivitySelected = false;
    emit(UpdateState());
  }

  void isModerateActivitySelectedFunction() {
    isModerateActivitySelected = true;
    isHeavyActivitySelected = false;
    isExtreemActivitySelected = false;
    isLowActivitySelected = false;
    isLightActivitySelected = false;
    emit(UpdateState());
  }

  void isHeavyActivitySelectedFunction() {
    isHeavyActivitySelected = true;
    isExtreemActivitySelected = false;
    isLowActivitySelected = false;
    isLightActivitySelected = false;
    isModerateActivitySelected = false;
    emit(UpdateState());
  }

  void isExtreemActivitySelectedFunction() {
    isExtreemActivitySelected = true;
    isLowActivitySelected = false;
    isLightActivitySelected = false;
    isModerateActivitySelected = false;
    isHeavyActivitySelected = false;
    emit(UpdateState());
  }

  void activityFactorDetect() {
    if (isLowActivitySelected == true) {
      activityFactor = 1.200;
    } else if (isLightActivitySelected == true) {
      activityFactor = 1.375;
    } else if (isModerateActivitySelected == true) {
      activityFactor = 1.550;
    } else if (isHeavyActivitySelected == true) {
      activityFactor = 1.725;
    } else if (isExtreemActivitySelected == true) {
      activityFactor = 1.900;
    }
    emit(UpdateState());
  }

  /// Age Calculating Function

  /// money
  void lowCostDietIsSelected() {
    poorMoney = true;
    mediumMoney = false;
    richMoney = false;
    emit(UpdateState());
  }

  void mediumCostDietIsSelected() {
    poorMoney = false;
    mediumMoney = true;
    richMoney = false;
    emit(UpdateState());
  }

  void highCostDietIsSelected() {
    poorMoney = false;
    mediumMoney = false;
    richMoney = true;
    emit(UpdateState());
  }

  /// BODY NEEDS CALCULATION FUNCTIONS

  int calculateAge() {
    final now = DateTime.now();
    int age = now.year - birthdayDate.year;
    if (now.month < birthdayDate.month ||
        (now.month == birthdayDate.month && now.day < birthdayDate.day)) {
      age--;
    }
    return age;
  }

  double bodyFatCalculate() {
    calculateAge();
    if (isSelectedMan == true &&
        isSelectedWoMan == false &&
        double.parse(waist.text) != 0 &&
        double.parse(neck.text) != 0 &&
        double.parse(tall.text) != 0) {
      fatPercentage =
          86.010 * log(double.parse(waist.text) - double.parse(neck.text)) -
              70.041 * log(double.parse(tall.text)) +
              36.76;
    } else if (isSelectedWoMan == true &&
        isSelectedMan == false &&
        double.parse(waist.text) != 0 &&
        double.parse(neck.text) != 0 &&
        double.parse(tall.text) != 0) {
      fatPercentage = 163.205 *
              log(double.parse(waist.text) +
                  double.parse(hip.text) -
                  double.parse(neck.text)) -
          97.684 * log(double.parse(tall.text)) -
          78.387;
    }
    leanBodyMass = double.parse(weight.text) * (1 - fatPercentage / 100);
    fatWeight = double.parse(weight.text) - leanBodyMass;
    return fatPercentage;
  }

  double bmrCalculation() {
    bodyFatCalculate();
    if (fatPercentage != 0) {
      basalMetabolicRate = 370 + (21.6 * leanBodyMass);
    } else if (fatPercentage == 0 && isSelectedMan == true) {
      basalMetabolicRate = 66.5 +
          (13.75 * double.parse(weight.text)) +
          (5.003 * double.parse(tall.text)) -
          (6.75 * age);
    } else {
      basalMetabolicRate = 655.1 +
          (9.563 * double.parse(weight.text)) +
          (1.850 * double.parse(tall.text)) -
          (4.676 * age);
    }
    return basalMetabolicRate;
  }

  double tdeeCalculator() {
    bmrCalculation();
    return totalDailyEnergyExpenditure = basalMetabolicRate * activityFactor;
  }

  /// FOODS EVERY INFORMATION
  void validateMeasuresForm() {
    if (isSelectedMan
        ? formKey.currentState!.validate()
        : womanFormKey.currentState!.validate()) {
      if (weight.text.isNotEmpty && waist.text.isNotEmpty) {
        tdeeCalculator();
        controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    }
  }

  double targetProtien() {
    return 0.0;
  }

  double targetCarbohydrate() {
    return 0.0;
  }

  double targetFats() {
    return 0.0;
  }

  String formatFoodNames(String foodNames) {
    List<String> foodList =
        foodNames.split(',').map((food) => food.trim()).toList();
    int length = foodList.length;
    if (length == 0) {
      return '';
    } else if (length == 1) {
      return foodList[0];
    } else if (length == 2) {
      return foodList.join(' And ');
    } else {
      // More than two food names
      String lastFood = foodList.removeLast();
      return '${foodList.join(', ')} And $lastFood';
    }
  }

  void updateUi() {
    emit(UpdateState());
  }

  String getFoodNames() {
    String foodNames = '';
    for (var food in selectedFoods) {
      foodNames += '${food.foodName},';
    }
    return foodNames;
  }

  /// FORM COMPLETION FUNCTION (SENDING DATA TO SERVER

  Future<void> completeForm(
      FormCompletionRequestBody formCompletionRequestBody) async {
    try {
      var response =
          await formCompletionRepoImp.completeForm(formCompletionRequestBody);

      if (response.status == "Success") {
        showToast(response.message);
      }
    } catch (e) {
      emit(FoodsStateError(e.toString()));
    }
  }
}
