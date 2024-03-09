import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class CoachRoutineInsertion{
  Future<void> routineInsertion(id,routineName) async {
    final response = await http.post(
        Uri.parse("http://192.168.1.6/coachiko/coachArea/routine_insertion.php"),
        body: {
          "user_id": id.toString(),
          "routinename": routineName.toString()

        });

    if (response.statusCode == 200) {
      // void psps(id){homeController.clientRoutines = getRoutineDataFSpecific(id) as WorkoutData?;}
      // psps(id);
      var data = json.decode(response.body);
      if (data["status"].toString() == "Success"){
        Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: 'Routine has been added successfully',
          toastLength: Toast.LENGTH_SHORT,
        );
      }

    } else {

      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Error Occured',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

}