import 'package:flutter/material.dart';
import '../../data/source/web_services/auth_web_services/auth_api_services.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  AuthApiServices apiCalls=AuthApiServices();
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


         try {
           await apiCalls.login(username.value.toString(),password.value.toString(),rememberMe.value);
           //await apiCalls.getFoodData();

        } catch (e) {
          print(e);
        }


    }
  }
}
