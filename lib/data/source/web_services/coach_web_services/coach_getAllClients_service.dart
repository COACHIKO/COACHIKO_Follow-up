import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../controller/coach_controllers/diet_making_controllers/diet_make_controller.dart';
import '../../../../linkapi.dart';
import '../../../../main.dart';
import '../../../../view/screens/coach_area/diet_presentation/diet_making_page.dart';
import '../../../model/client_user_model.dart';

class GetAllClients {
  Future<void> getCoachClients() async {
    final dietMakingController = Get.put(DietMakingController());

    var url = Uri.http(AppLink.server, AppLink.getCoachClient);

    try {
      final response = await http.post(url, body: {
        "id": myServices.sharedPreferences
            .getInt("user")
            .toString(), // Replace with the actual user ID
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['status'] == 'Success') {
          if (data['data'] is List) {
            List<ClientData> userList = (data['data'] as List)
                .map((userJson) => ClientData.fromJson(userJson))
                .toList();

            dietMakingController.coachClients = userList;
          } else {
            // Handle the case where 'data' is not a list
            Fluttertoast.showToast(
              msg: 'Invalid data format',
              backgroundColor: Colors.red,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
            );
          }
        } else {
          // Handle the case where the server responds with an error
          Fluttertoast.showToast(
            msg: 'Failed to load user data',
            backgroundColor: Colors.red,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
          );
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: '$error',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}
