import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/models/routine_request_body.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/models/routine_response.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/display_client_routine/data/models/routine_crud_request_body.dart';

import '../../../../../../../core/networking/api_service.dart';

import '../models/routine_insert_response.dart';
import 'client_routines_repo.dart';

class ClientRoutinesRepoImp implements ClientRoutinesRepo {
  final ApiService _apiService;
  ClientRoutinesRepoImp(this._apiService);

  @override
  Future<List<Routine>> getRoutine(
      RoutineRequestBody routineRequestBody) async {
    try {
      var response =
          await _apiService.getRoutine(routineRequestBody: routineRequestBody);
      var parsedData = RoutineResponse.fromJson(response);
      return parsedData.routines;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<RoutineCrudResponse> insertRoutine(
      RoutineInsertRequestBody routineInsertRequestBody) async {
    try {
      var response = await _apiService.routineInsert(
          routineInsertRequestBody: routineInsertRequestBody);
      var parsedData = RoutineCrudResponse.fromJson(response);
      return parsedData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<RoutineCrudResponse> deleteRoutine(
      RoutineDeleteRequestBody routineDeleteRequestBody) async {
    try {
      var response = await _apiService.routineDelete(
          routineDeleteRequestBody: routineDeleteRequestBody);
      print(response);

      var parsedData = RoutineCrudResponse.fromJson(response);
      return parsedData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
