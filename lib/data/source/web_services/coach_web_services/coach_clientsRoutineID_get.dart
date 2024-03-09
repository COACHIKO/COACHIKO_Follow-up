import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/routine_model.dart';

class GetRoutinesSpecificId{

  Future<WorkoutData> getRoutineDataFSpecific(id) async {
    final response = await http.post(
        Uri.parse("http://192.168.1.6/coachiko/get_routine_data_new.php"),
        body: {"user": id.toString()});

    if (response.statusCode == 200) {
      // void psps(id){homeController.clientRoutines = getRoutineDataFSpecific(id) as WorkoutData?;}
      // psps(id);
      return WorkoutData.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load data');
    }
  }

}