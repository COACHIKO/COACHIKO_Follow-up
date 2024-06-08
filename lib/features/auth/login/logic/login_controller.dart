// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:followupapprefactored/main.dart';
// import 'package:followupapprefactored/view/screens/client_area/client_home_screen.dart';
// import 'package:followupapprefactored/view/screens/coach_area/coach_home_screen.dart';
// import 'package:get/get.dart';
// import '../data/models/login_request_model.dart';
// import '../data/repository/login_repo_impl.dart';

// class LoginController extends GetxController {
//   final LoginRepoImp loginRepoImp = LoginRepoImp();
//   var username = ''.obs;
//   var password = ''.obs;
//   var obscurePassword = true.obs;
//   var rememberMe = false.obs;
//   String firebaseToken = "";
//   var formKey = GlobalKey<FormState>().obs;
//   void togglePasswordVisibility() {
//     obscurePassword.toggle();
//   }

//   void toggleRememberMe(bool? value) {
//     rememberMe.value = value ?? false;
//   }

//   void getToken() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     firebaseToken = token.toString();
//   }

//   @override
//   void onInit() {
//     getToken();
//     super.onInit();
//   }

//   void signIn() async {
//     if (formKey.value.currentState!.validate()) {
//       var response = await loginRepoImp.login(
//         LoginRequestBody(
//           username: username.value.toString(),
//           password: password.value.toString(),
//           token: firebaseToken.toString(),
//         ),
//         rememberMe.value,
//       );

//       if (response.status == "Success") {
//         myServices.sharedPreferences.setInt("user", response.userData.id);
//         myServices.sharedPreferences
//             .setString("first_name", response.userData.firstName);
//         myServices.sharedPreferences
//             .setString("second_name", response.userData.secondName);
//         myServices.sharedPreferences
//             .setString("email", response.userData.email);
//         myServices.sharedPreferences
//             .setInt("RelatedtoCoachID", response.userData.relatedToCoachID);
//         myServices.sharedPreferences
//             .setInt("isCoach", response.userData.isCoach=="Coach"?1:0);
//         myServices.sharedPreferences.setBool("rememberMe", rememberMe.value);

//         if (response.userData.isCoach == "Client") {
//           Get.offAll(const ClientHome());
//         } else {
//           Get.offAll(const CoachHome());
//         }

//         // Show welcome message
//         Fluttertoast.showToast(
//           msg:
//               'Welcome, ${myServices.sharedPreferences.getString("first_name")}',
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//           toastLength: Toast.LENGTH_SHORT,
//         );
//       } else {
//         Fluttertoast.showToast(
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           msg: response.message.toString(),
//           toastLength: Toast.LENGTH_SHORT,
//         );
//       }
//     }
//   }
// }
