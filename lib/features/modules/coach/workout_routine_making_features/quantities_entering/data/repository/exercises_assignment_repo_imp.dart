import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/quantities_entering/data/models/exercises_assignment_request_body.dart';

import '../../../../../../../../../../../core/networking/api_service.dart';
import '../models/exercises_assignment_response.dart';
import 'exercises_assignment_repo.dart';

class ExercisesAssignmentRepoImp implements exercisesAssignmentRepo {
  final ApiService _apiService;
  ExercisesAssignmentRepoImp(this._apiService);

  @override
  Future<ExerciseAssignmentResponse> assignExercises(
      ExerciseAssignmentRequestBody exerciseAssignmentRequestBody) async {
    try {
      var response = await _apiService.routineAssignExercises(
          exerciseAssignmentRequestBody: exerciseAssignmentRequestBody);
      var parsedData = ExerciseAssignmentResponse.fromJson(response);
      return parsedData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
