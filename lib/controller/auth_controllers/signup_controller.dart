import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_controller.dart';

class SignUpController extends GetxController {
  RxBool isCoach = false.obs;
  var firstName = ''.obs;
  var secondName = ''.obs;
  var username = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var coachUserName = ''.obs;

  final GlobalKey<FormState> signupkey = GlobalKey<FormState>();

  void toggleIsCoach() {
    isCoach.value = !isCoach.value;
  }

  void signUp() async{
    if (signupkey.currentState!.validate()) {
      final ApiController apiController = Get.put(ApiController());

      if (signupkey.currentState!.validate()) {
        signupkey.currentState!.save();
        await apiController.register(
          firstName.toString(),
          secondName.toString(),
          isCoach==true.obs?"1":"0",
          coachUserName.toString(),
          username.toString(),
          password.toString(),
          email.toString(),
        );
      }

    }
  }
}
