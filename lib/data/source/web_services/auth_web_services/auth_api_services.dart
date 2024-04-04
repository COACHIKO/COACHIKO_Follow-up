// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import '../../../../features/auth/login/data/models/login_request_model.dart';
// import '../../../../features/auth/login/data/models/login_response_model.dart';
// import '../../../../linkapi.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../../../view/screens/auth_screens/fork_usering_page.dart';

// // Define your response body model

// class AuthApiServices {
//   Future<void> register(
//     String firstName,
//     String secondName,
//     String isCoach,
//     String coachUsername,
//     String user,
//     String pass,
//     String email,
//   ) async {
//     var url = Uri.http(AppLink.server, AppLink.signUpKey);
//     var response = await http.post(url, body: {
//       "first_name": firstName,
//       "second_name": secondName,
//       "isCoach": isCoach,
//       "coach_user_name": coachUsername,
//       "username": user,
//       "email": email,
//       "password": pass,
//     });
//     var data = json.decode(response.body);

//     if (data == "Error") {
//       Fluttertoast.showToast(
//         backgroundColor: Colors.orange,
//         textColor: Colors.white,
//         msg: 'User already exists!',
//         toastLength: Toast.LENGTH_SHORT,
//       );
//     } else {
//       Get.offAll(const ForkUseringPage());
//       Fluttertoast.showToast(
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         msg: 'Registration Successful',
//         toastLength: Toast.LENGTH_SHORT,
//       );
//     }
//   }

//   /// login Function

//   // Future<LoginResponse> login(
//   //     LoginRequestBody loginRequestBody, rememberme) async {
//   //   var url = Uri.http(AppLink.server, AppLink.signInKey);
//   //   var response =
//   //       await http.post(url, body: json.encode(loginRequestBody.toJson()));
//   //   var responseData = json.decode(response.body);
//   //   var parsedData = LoginResponse.fromJson(responseData);
//   //   return parsedData;
//   // }
// }
