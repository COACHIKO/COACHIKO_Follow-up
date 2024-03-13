import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../linkapi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../main.dart';
import '../../../../view/screens/auth_screens/fork_usering_page.dart';
import '../../../../view/screens/client_area/client_home_screen.dart';
import '../../../../view/screens/coach_area/coach_home_page.dart';
class AuthApiServices{
  Future<void> register(
      String firstName,
      String secondName,
      String isCoach,
      String coachusername,
      String user,
      String pass,
      String email,
      ) async {
    var url = Uri.http(AppLink.server, AppLink.signUpKey);
    var response = await http.post(url, body: {
      "first_name": firstName,
      "second_name": secondName,
      "isCoach": isCoach,
      "coach_user_name": coachusername,
      "username": user,
      "email": email,
      "password": pass,
    });
    var data = json.decode(response.body);

    if (data == "Error") {
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: 'User already exists!',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Get.offAll(const ForkUseringPage());
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Registration Successful',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  /// login Function
  Future<void> login(String user, String pass, rememberme) async {
    var url = Uri.http(
      AppLink.server,
      AppLink.signInKey,
    );
    var response = await http.post(url, body: {
      "username": user,
      "password": pass,
    });
    var data = json.decode(response.body);

    if (data["status"].toString() == "Success") {
      if (rememberme == true) {
        myServices.sharedPreferences.setInt("user", data["data"]["id"]);
        myServices.sharedPreferences.setString("first_name", data["data"]["first_name"]);
        myServices.sharedPreferences.setString("second_name", data["data"]["second_name"]);
        myServices.sharedPreferences.setString("email", data["data"]["email"]);
        myServices.sharedPreferences.setInt("RelatedtoCoachID", data["data"]["RelatedtoCoachID"]);
        myServices.sharedPreferences.setInt("isCoach", data["data"]["isCoach"]);
        myServices.sharedPreferences.setBool("rememberMe", true);

        if (data["data"]["isCoach"] == 0) {
          Get.offAll(const HomePage());
        } else {
          Get.offAll(const CoachHome());
        }
      } else {
        myServices.sharedPreferences.setInt("user", data["data"]["id"]);
        myServices.sharedPreferences
            .setString("first_name", data["data"]["first_name"]);
        myServices.sharedPreferences
            .setString("second_name", data["data"]["second_name"]);
        myServices.sharedPreferences
            .setInt("RelatedtoCoachID", data["data"]["RelatedtoCoachID"]);
        myServices.sharedPreferences.setInt("isCoach", data["data"]["isCoach"]);
        myServices.sharedPreferences.setBool("rememberMe", false);

        if (data["data"]["isCoach"] == 0) {
          Get.offAll(const HomePage());
        } else {
          Get.offAll(const CoachHome());
        }
      }

      Fluttertoast.showToast(
        msg: 'Welcome, ${myServices.sharedPreferences.getString("first_name")}',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Username and password invalid',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

}