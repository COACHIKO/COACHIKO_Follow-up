import 'package:flutter/material.dart';
import '../api_controller.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final ApiController apiController = ApiController(); // Create an instance of ApiController
  var username = ''.obs;
  var password = ''.obs;
  var obscurePassword = true.obs;
  var rememberMe = false.obs;
  var formKey = GlobalKey<FormState>().obs;
  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }
  void signIn()async {
    if (formKey.value.currentState!.validate()) {
      await apiController.login(username.value.toString(),password.value.toString(),rememberMe.value);
      await apiController.getFoodData();}
  }
}
