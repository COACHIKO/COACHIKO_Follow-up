// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
//  import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../controller/routines_page_controller.dart';
// import '../../linkapi.dart';
// import '../model/routine_model.dart';
//
// class ApiCalls{
//   HomeController homeController = Get.put(HomeController());
//
//   Future<void> fetchData() async {
//     var url = Uri.http(
//       AppLink.server, AppLink.getuserdata, {'q': '{http}'},);
//
//     try {
//       final response = await http.post(url, body: {
//         "user": 10.toString(), // Replace with the actual user ID
//       });
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         homeController.routines = (data['data'] as Map<String, dynamic>).entries.map((entry) {
//           return Routine.fromJson({
//             'routineName': entry.key,
//             'exercises': entry.value,
//           });
//         }).toList();
//          Fluttertoast.showToast(
//           msg: 'Your Data Loaded Champion',
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//           toastLength: Toast.LENGTH_LONG,
//         );
//
//
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (error) {
//
//       // Handle error appropriately
//     }
//    }
//
// }