import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../linkapi.dart';

class UpdateUserData {
  Future<void> updateClientData(
    fatPercentage,
    id,
    genderSelect,
    goalSelect,
    String activitySelect,
    birthdayDate,
    weight,
    tall,
    costSelect,
    waist,
    neck,
    hip,
    tdee,
    preferredFoods,
    chest,
    arms,
    wrist,
    targetProtein,
    targetCarb,
    targetFat,
    currentStep,
  ) async {
    try {
      var url = Uri.http(
        AppLink.server,
        '/coachikoFollowApp/client_user_data_insert_update.php',
      );
      var response = await http.post(url, body: {
        "fatPercentage": fatPercentage.toString(),
        "id": id.toString(),
        "preferedFoods": preferredFoods.toString(),
        "genderSelect": genderSelect.toString(),
        "goalSelect": goalSelect.toString(),
        "activitySelect": activitySelect.toString(),
        "weight": weight.toString(),
        "tall": tall.toString(),
        "costSelect": costSelect.toString(),
        "waist": waist.toString(),
        "neck": neck.toString(),
        "hip": hip.toString(),
        "chest": chest.toString(),
        "arms": arms.toString(),
        "wrist": wrist.toString(),
        "tdee": tdee.toString(),
        "targetProtien": targetProtein.toString(),
        "targetCarbohdrate": targetCarb.toString(),
        "targetFat": targetFat.toString(),
        "current_step": currentStep.toString(),
        "birthdayDate": birthdayDate,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data["status"] == "Error") {
          Fluttertoast.showToast(
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            msg: '${data["message"]}',
            toastLength: Toast.LENGTH_SHORT,
          );
        } else {
          Fluttertoast.showToast(
            backgroundColor: Colors.green,
            textColor: Colors.white,
            msg: '${data["message"]}',
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      //print('Error: $e');
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'An error occurred: $e',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
