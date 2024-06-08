import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/display_client_routine/data/models/routine_crud_request_body.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/display_client_routine/data/models/routine_insert_response.dart';

abstract class EditRoutineRepo {
  Future<RoutineCrudResponse> updateRoutineName(
      RoutineUpdateRequestBody routineUpdateRequestBody);

  Future<RoutineCrudResponse> deleteRoutine(
      RoutineDeleteRequestBody routineDeleteRequestBody);
}
