import '../models/exercises_assignment_request_body.dart';
import '../models/exercises_assignment_response.dart';

abstract class exercisesAssignmentRepo {
  Future<ExerciseAssignmentResponse> assignExercises(
      ExerciseAssignmentRequestBody exerciseAssignmentRequestBody);
}
