import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/source/web_services/auth_web_services/auth_api_services.dart';

class SignUpController extends GetxController {
  AuthApiServices apiCalls=AuthApiServices();

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

      if (signupkey.currentState!.validate()) {
        signupkey.currentState!.save();
        await apiCalls.register(
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
