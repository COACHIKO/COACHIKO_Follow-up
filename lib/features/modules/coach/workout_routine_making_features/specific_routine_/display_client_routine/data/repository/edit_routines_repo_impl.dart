import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/display_client_routine/data/models/routine_crud_request_body.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/display_client_routine/data/models/routine_insert_response.dart';
import 'edit_routines_repo.dart';

class EditRoutineRepoImp implements EditRoutineRepo {
  final ApiService _apiService;
  EditRoutineRepoImp(this._apiService);

  @override
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

  @override
  Future<RoutineCrudResponse> updateRoutineName(
      RoutineUpdateRequestBody routineUpdateRequestBody) async {
    try {
      var response = await _apiService.routineUpdate(
          routineUpdateRequestBody: routineUpdateRequestBody);
      var parsedData = RoutineCrudResponse.fromJson(response);
      return parsedData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
