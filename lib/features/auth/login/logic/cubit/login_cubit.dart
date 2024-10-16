import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/services/shared_pref/shared_pref.dart';
import '../../data/models/login_request_body.dart';
import '../../data/repository/login_repo_impl.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepoImp loginRepoImp;

  LoginCubit(this.loginRepoImp) : super(LoginState());
  late String username;
  late String password;
  bool rememberMe = false;
  bool passwordVisibility = false;

  Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  void signIn(context) async {
    if (state.formKey.currentState!.validate()) {
      var token = await getToken();
      var response = await loginRepoImp.login(
        LoginRequestBody(
          username: username,
          password: password,
          token: token!,
        ),
        rememberMe,
      );

      if (response.status == "Success") {
        SharedPref().setInt("user", response.userData!.id);
        SharedPref().setString("first_name", response.userData!.firstName);
        SharedPref().setString("second_name", response.userData!.secondName);
        SharedPref().setString("email", response.userData!.email);
        SharedPref()
            .setInt("RelatedtoCoachID", response.userData!.relatedToCoachID);
        SharedPref().setInt("currentStep", response.userData!.currentStep);
        SharedPref()
            .setInt("isCoach", response.userData!.isCoach == "Coach" ? 1 : 0);
        SharedPref().setBool("rememberMe", rememberMe);

        if (response.userData!.isCoach == "Client" &&
            response.userData!.currentStep == 0) {
          GoRouter.of(context).go(Routes.formComplection);
        } else if (response.userData!.isCoach == "Client" &&
            response.userData!.currentStep == 1) {
          context.go(context, Routes.currentStage);
          GoRouter.of(context).go(Routes.currentStage);
        } else if (response.userData!.isCoach == "Client" &&
            response.userData!.currentStep == 2) {
          GoRouter.of(context).go(Routes.clientHome);
        } else {
          GoRouter.of(context).go(Routes.coachHome);
        }

        Fluttertoast.showToast(
          msg: 'Welcome, ${SharedPref().getString("first_name")}',
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
