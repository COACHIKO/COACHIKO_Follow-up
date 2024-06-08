import '../../../../../../../core/networking/api_service.dart';
import '../models/routine_request_body.dart';
import '../models/routine_response.dart';
import 'routine_repo.dart';

class RoutineRepoImp implements RoutineRepo {
  final ApiService _apiService;
  RoutineRepoImp(this._apiService);

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
}
