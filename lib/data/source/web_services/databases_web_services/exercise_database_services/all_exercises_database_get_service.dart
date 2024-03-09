import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../view/screens/coach_area/workout_plan_making_page.dart';
import '../../../../model/routine_model.dart';
class GetAllExercisesDataBase{
  final exerciseDataBaseController = Get.put(ExerciseController());

  Future<void> getExercises() async {
    void assignExercises(List<Exercise> exercises) {
      exerciseDataBaseController.exercises.assignAll(exercises);
      exerciseDataBaseController.selectedExercises.assignAll(exercises);
    }
    final url = Uri.parse(
        'http://192.168.1.6/coachikoFollowApp/get_excersise_data.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final exercises = data['data'] as List;

        // Map JSON data to ExerciseDatabaseModel objects
        final mappedExercises =
        exercises.map((exercise) => Exercise.fromJson(exercise)).toList();

        // Assuming exerciseDataBaseController.exercises is RxList<ExerciseDatabaseModel>
        assignExercises(mappedExercises);
      } catch (e) {
        // Handle any exceptions that might occur during decoding or mapping
        print('Error: $e');
      }
    } else {
      // Throw an exception if the response status code is not 200
      throw Exception('Failed to load exercises');
    }


  }

}