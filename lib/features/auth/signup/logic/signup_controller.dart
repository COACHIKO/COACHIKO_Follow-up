import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:followupapprefactored/features/auth/signup/data/repository/signup_repo_impl.dart';
import 'package:get/get.dart';

import '../data/models/signup_request_model.dart';

class SignUpController extends GetxController {
  static SignupRepoImp get instance => Get.find();

  final SignupRepoImp signupRepoImp = SignupRepoImp(ApiService(Dio()));

  RxBool isCoach = false.obs;
  var firstName = ''.obs;
  var secondName = ''.obs;
  var username = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var coachUserName = ''.obs;

  final GlobalKey<FormState> signupkey = GlobalKey<FormState>();
  void toggleCoach() {
    isCoach.value = !isCoach.value;
    coachUserName = ''.obs;
  }

  int getIsCoach() {
    int isCoachDigit = 0;
    if (isCoach.isTrue) {
      isCoachDigit = 1;
    } else {
      isCoachDigit = 0;
    }
    return isCoachDigit;
  }

  Future<void> signUp() async {
    if (signupkey.currentState!.validate()) {
      var response = await signupRepoImp.register(SignupRequestBody(
        username: username.value,
        password: password.value,
        email: email.value,
        firstName: firstName.value,
        secondName: secondName.value,
        isCoach: getIsCoach(),
        coachUserName: coachUserName.value,
      ));
      if (response.status == "success") {
        Get.offAllNamed("/forkUsering");
        Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: response.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: response.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    }
  }
}




  // await apiCalls.register(
  //         firstName.toString(),
  //         secondName.toString(),
  //         isCoach==true.obs?"1":"0",
  //         coachUserName.toString(),
  //         username.toString(),
  //         password.toString(),
  //         email.toString(),
  //       );