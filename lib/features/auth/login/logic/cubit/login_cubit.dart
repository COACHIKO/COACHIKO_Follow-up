import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:followupapprefactored/features/modules/client/navigation_bar/ui/client_navigation_bar.dart';
import 'package:followupapprefactored/features/modules/client/phases_cases/form_completion/ui/form_completion.dart';
import 'package:followupapprefactored/features/modules/client/phases_cases/waiting_phase/ui/current_stage_page.dart';
import 'package:get/get.dart';
import '../../../../../main.dart';
import '../../../../modules/coach/navigation_bar/ui/coach_navigation_bar.dart';
import '../../data/models/login_request_body.dart';
import '../../data/repository/login_repo_impl.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepoImp loginRepoImp;

  LoginCubit(this.loginRepoImp) : super(LoginState());

  void setUsername(String value) {
    emit(state.copyWith(username: value));
  }

  void setPassword(String value) {
    emit(state.copyWith(password: value));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleRememberMe(bool? value) {
    emit(state.copyWith(rememberMe: value ?? false));
  }

  void getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    emit(state.copyWith(firebaseToken: token ?? ''));
  }

  void signIn() async {
    if (state.formKey.currentState!.validate()) {
      var response = await loginRepoImp.login(
        LoginRequestBody(
          username: state.username,
          password: state.password,
          token: state.firebaseToken,
        ),
        state.rememberMe,
      );

      if (response.status == "Success") {
        myServices.sharedPreferences.setInt("user", response.userData!.id);
        myServices.sharedPreferences
            .setString("first_name", response.userData!.firstName);
        myServices.sharedPreferences
            .setString("second_name", response.userData!.secondName);
        myServices.sharedPreferences
            .setString("email", response.userData!.email);
        myServices.sharedPreferences
            .setInt("RelatedtoCoachID", response.userData!.relatedToCoachID);
        myServices.sharedPreferences
            .setInt("currentStep", response.userData!.currentStep);
        myServices.sharedPreferences
            .setInt("isCoach", response.userData!.isCoach == "Coach" ? 1 : 0);
        myServices.sharedPreferences.setBool("rememberMe", state.rememberMe);

        if (response.userData!.isCoach == "Client" &&
            response.userData!.currentStep == 0) {
          Get.offAll(const FormComplectionView());
        } else if (response.userData!.isCoach == "Client" &&
            response.userData!.currentStep == 1) {
          Get.offAll(const CurrentStage());
        } else if (response.userData!.isCoach == "Client" &&
            response.userData!.currentStep == 2) {
          Get.offAll(const ClientNavigationBar());
        } else {
          Get.offAll(const CoachNavigationBar());
        }

        // Show welcome message
        Fluttertoast.showToast(
          msg:
              'Welcome, ${myServices.sharedPreferences.getString("first_name")}',
          backgroundColor: Colors.green,
          textColor: Colors.white,
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
