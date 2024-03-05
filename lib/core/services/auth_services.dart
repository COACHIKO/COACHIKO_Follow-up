// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import '../../main.dart';
// bool? bo;
// class AuthService{
//   ///Google SIGN IN
//   Future register(String user, String pass, String email) async {
//     var url = Uri.http("192.168.1.2", '/coachikoapp/auth/logingoogle.php', );
//     var response = await http.post(url, body: {
//       "username": user,
//       "email": email,
//       "password": pass,
//     });
//     var data = json.decode(response.body);
//     if (data["status"].toString() == "Success") {
//       myServices.sharedPreferences.setInt("user", data["data"]["id"]);}else if(data["status"].toString() == "Account Created Successfully"){
//       register(user, pass, email);
//     }
//
//
// }
//
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   Future<dynamic> hangleSignIn() async {
//     try{
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//       await _auth.signInWithCredential(credential);
//     }catch(e){ print('Error signing in with Google: $e');}
//   }
//   /// Google Sign Out
//   Future <void> hangleSignOut()  async{
//     await _googleSignIn.signOut();
//     await _auth.signOut() ;
//     myServices.sharedPreferences.remove("goHome");
//   }
//   /// End Of Google Hangle
//
//
//
//
//
//
//
//
//
// }
//
// Future login(user,pass) async {
//   var url = Uri.http("192.168.8.12", '/flutter_login/login.php', {'q': '{http}'});
//   var response = await http.post(url, body: {
//     "username": user.text,
//     "password": pass.text,
//   });
//   var data = json.decode(response.body);
//   if (data.toString() == "Success") {
//     Fluttertoast.showToast(
//       msg: 'Login Successful',
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//       toastLength: Toast.LENGTH_SHORT,
//     );
//
//
//   } else {
//     Fluttertoast.showToast(
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       msg: 'Username and password invalid',
//       toastLength: Toast.LENGTH_SHORT,
//     );
//   }
// }
