import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../controller/client_controllers/routines_page_controller.dart';
import '../../../../main.dart';
import '../../../model/routine_model.dart';

class ClientRoutinesGetService {
  Future<WorkoutData> getRoutineData(state) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.6/coachiko/get_routine_data_new.php"),
        body: {"user": myServices.sharedPreferences.getInt("user").toString()},
      );

      if (response.statusCode == 200) {
        final workoutData = WorkoutData.fromJson(jsonDecode(response.body)['data']);
        state.value = RoutinesState.loaded;
        return workoutData;
      } else {
        throw Exception('Failed to load routine data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching routine data: $e');
      state.value = RoutinesState.error;
      throw Exception('Error fetching routine data');
    }
  }
}
