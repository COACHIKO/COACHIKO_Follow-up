import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/models/routine_request_body.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/display_client_routine/data/models/routine_insert_response.dart';

import '../../../../../client/routine/routine_get/data/models/routine_response.dart';
import '../models/routine_crud_request_body.dart';

abstract class ClientRoutinesRepo {
  Future<List<Routine>> getRoutine(RoutineRequestBody routineRequestBody);
  Future<RoutineCrudResponse> insertRoutine(
      RoutineInsertRequestBody routineInsertRequestBody);

  Future<RoutineCrudResponse> deleteRoutine(
      RoutineDeleteRequestBody routineDeleteRequestBody);
}
