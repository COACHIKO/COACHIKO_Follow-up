import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class AssignExerciseToRoutine {
  Future<void> assignExerciseToRoutine(numberOfExercises,userId, exerciseId, sets, reps, rir, rest, routineId) async {
    // Check if any input is empty
    if (userId.isEmpty ||
        exerciseId.isEmpty ||
        sets <= 0 ||
        reps <= 0 ||
        rir < 0 ||
        rest < 0 ||
        routineId.isEmpty) {
      throw Exception('Invalid input');
    }

    final response = await http.post(
      Uri.parse("http://192.168.1.6/coachiko/coachArea/excersise_assign_to_routine.php"),
      body: {
        "num":numberOfExercises.toString(),
        "user_id": userId,
        "excersise_id": exerciseId,
        "sets": sets.toString(), // Convert int to String
        "reps": reps.toString(), // Convert int to String
        "rir": rir.toString(),   // Convert int to String
        "rest": rest.toString(), // Convert int to String
        "routineId": routineId,
      },
    );

    var data = json.decode(response.body);
    if (response.statusCode == 200 && data['status']=="Success") {

      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {

      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
      );


    }

  }
}
