import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/source/web_services/client_web_services/client_form_update_service.dart';
import '../../../main.dart';
import '../../coach_controllers/diet_making_controllers/diet_make_controller.dart';


class FormComplectionController extends GetxController {
  static FormComplectionController get instance => Get.find();
   UpdateUserData updateUserData = UpdateUserData();
  final coachHomeController = Get.find<DietMakingController>();

  ///                                      VARIABLE LAND                                                     ///

  final controller = PageController();

  /// Gender Selection
  bool isSelectedMan = false;
  bool isSelectedWoMan = false;
  late bool gender; //true is man //false woman

  /// Goal Selection
  bool isSelectedLoseWeight = false;
  bool isSelectedGainWeight = false;
  bool isSelectedMaintainWeight = false;

  /// Activity Selection
  bool   isLowActivitySelected = false;
  bool   isLightActivitySelected = false;
  bool   isModerateActivitySelected = false;
  bool   isHeavyActivitySelected = false;
  bool   isExtreemActivitySelected = false;
  double activityFactor = 0.0;

  /// Age Calculating
  int age = 0;
  DateTime currentDate = DateTime.now();
  DateTime birthdayDate = DateTime(1950, 1, 1);

  /// TALL AND WEIGHT
  var weight = ''.obs;
  var tall = ''.obs;
  var waist = ''.obs;
  var neck =  ''.obs;
  var arms =  ''.obs;
  var calves =  ''.obs;
  var hip =  ''.obs;
  var chest =  ''.obs;
  var formKey = GlobalKey<FormState>().obs;
  var womanFormKey = GlobalKey<FormState>().obs;
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


  /// Selected FOODS

  ///                                      VARIABLE LAND ENDS HERE                                                     ///

  ///                                      FUNCTION LAND STARTS HERE                                                     ///

  /// GENDER SELECT
  void womanSelected() {
    isSelectedMan = false;
    isSelectedWoMan = true;
    update();
    if (isSelectedMan == false) {
      gender = false;
    }
  }

  void manSelected() {
    isSelectedWoMan = false;
    isSelectedMan = true;
    update();
    if (isSelectedMan == true) {
      gender = true;
    }
  }

  /// Goal Selection Function
  void loseWeightSelected() {
    isSelectedLoseWeight = true;
    isSelectedGainWeight = false;
    isSelectedMaintainWeight = false;
    update();
  }

  void gainWeightSelected() {
    isSelectedGainWeight = true;
    isSelectedLoseWeight = false;
    isSelectedMaintainWeight = false;
    update();
  }

  void maintainWeightSelected() {
    isSelectedMaintainWeight = true;
    isSelectedGainWeight = false;
    isSelectedLoseWeight = false;
    update();
  }

  /// Activity Selection Function
  void isLowActivitySelectedFunction() {
    isLowActivitySelected = true;
    isLightActivitySelected = false;
    isModerateActivitySelected = false;
    isHeavyActivitySelected = false;
    isExtreemActivitySelected = false;
    update();
  }

  void isLightActivitySelectedFunction() {
    isLightActivitySelected = true;
    isModerateActivitySelected = false;
    isHeavyActivitySelected = false;
    isExtreemActivitySelected = false;
    isLowActivitySelected = false;
    update();
  }

  void isModerateActivitySelectedFunction() {
    isModerateActivitySelected = true;
    isHeavyActivitySelected = false;
    isExtreemActivitySelected = false;
    isLowActivitySelected = false;
    isLightActivitySelected = false;
    update();
  }

  void isHeavyActivitySelectedFunction() {
    isHeavyActivitySelected = true;
    isExtreemActivitySelected = false;
    isLowActivitySelected = false;
    isLightActivitySelected = false;
    isModerateActivitySelected = false;
    update();
  }

  void isExtreemActivitySelectedFunction() {
    isExtreemActivitySelected = true;
    isLowActivitySelected = false;
    isLightActivitySelected = false;
    isModerateActivitySelected = false;
    isHeavyActivitySelected = false;
    update();
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
    update();
  }

  /// Age Calculating Function

  /// money
  void lowCostDietIsSelected() {
    poorMoney = true;
    mediumMoney = false;
    richMoney = false;
    update();
  }

  void mediumCostDietIsSelected() {
    poorMoney = false;
    mediumMoney = true;
    richMoney = false;
    update();
  }

  void highCostDietIsSelected() {
    poorMoney = false;
    mediumMoney = false;
    richMoney = true;
    update();
  }

  /// BODY NEEDS CALCULATION FUNCTIONS

  int    calculateAge() {
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
     if (isSelectedMan == true && isSelectedWoMan == false && double.parse(waist.value)!=0 && double.parse(neck.value)!=0 && double.parse(tall.value)!=0) {
      fatPercentage = 86.010 * log(double.parse(waist.value) - double.parse(neck.value)) - 70.041 * log(double.parse(tall.value)) + 36.76;
    }
     else if (isSelectedWoMan == true && isSelectedMan == false && double.parse(waist.value)!=0 && double.parse(neck.value)!=0 && double.parse(tall.value)!=0) {
      fatPercentage = 163.205 * log(double.parse(waist.value) + double.parse(hip.value) - double.parse(neck.value)) - 97.684 * log(double.parse(tall.value)) - 78.387;
    }
     leanBodyMass =double.parse(weight.value) * (1 - fatPercentage / 100);
     fatWeight=double.parse(weight.value)-leanBodyMass;
     return fatPercentage;
  }
  double bmrCalculation(){
    bodyFatCalculate();
    if(fatPercentage!=0){
      basalMetabolicRate  = 370 + (21.6 *leanBodyMass);
    }else if(fatPercentage==0&&isSelectedMan==true){
      basalMetabolicRate = 66.5 + (13.75 * double.parse(weight.value)) + (5.003 * double.parse(tall.value) ) - (6.75 * age);
    }else{
      basalMetabolicRate = 655.1 + (9.563 * double.parse(weight.value)) + (1.850 * double.parse(tall.value)) - (4.676 * age);
    }
    return basalMetabolicRate;
   }
  void tdeeCalculator(){
    bmrCalculation();
    totalDailyEnergyExpenditure=basalMetabolicRate*activityFactor;
   }
  String selectedFoods='';

  /// FOODS EVERY INFORMATION
  void validateMeasuresForm() {
    if (isSelectedMan? formKey.value.currentState!.validate():womanFormKey.value.currentState!.validate()) {


      if (weight.value.isNotEmpty  && waist.value.isNotEmpty) {
        tdeeCalculator();
        controller.nextPage(duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
      }
    }





  }



  finshClientForm()async{
    List<String> selectedFoodNames = coachHomeController.filteredFoodList.asMap().entries.where((entry) => coachHomeController.selectedIndexes.contains(entry.key)).map((entry) => entry.value.foodName).toList();
    selectedFoods = selectedFoodNames.join(', ');
try {
  await updateUserData.updateClientData(
      fatPercentage.obs,
      myServices.sharedPreferences.getInt("user").toString(),
      isSelectedMan ? 0.toString() : 1.toString(),
      isSelectedLoseWeight ? 0.toString() : isSelectedGainWeight ? 1.toString() : 2.toString(),
      isLowActivitySelected ? 0.toString() : isLightActivitySelected ? 1.toString() : isModerateActivitySelected ? 2.toString(): isHeavyActivitySelected ? 3.toString() : 4.toString(), birthdayDate.toIso8601String(),
      weight.value.toString(),
      tall.value.toString(),
      poorMoney ? "0" : mediumMoney ? "1" : "2",
      waist.value,
      neck.value,
      hip.value,
      totalDailyEnergyExpenditure.obs.toString(),
      selectedFoods,
      chest.value,
      arms.value.toString(),
      waist.value,
      targetProtein.toString(),
      targetCarbs.toString(),
      targetFat.toString(),
      1.toString()
  );
}catch(e){
  //print(e.toString());
}




    controller.nextPage(duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);

  }



}
