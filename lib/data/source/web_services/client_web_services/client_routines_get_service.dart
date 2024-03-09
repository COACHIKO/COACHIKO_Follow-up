import '../../../../main.dart';
import '../../../model/routine_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ClientRoutinesGetService{
  Future<WorkoutData> getRoutineData() async {
    final response = await http.post(
        Uri.parse("http://192.168.1.6/coachiko/get_routine_data_new.php"),
        body: {"user": myServices.sharedPreferences.getInt("user").toString()});

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return WorkoutData.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load data');
    }
  }

}