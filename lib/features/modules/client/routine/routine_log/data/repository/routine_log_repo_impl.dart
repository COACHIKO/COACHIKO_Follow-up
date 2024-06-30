import 'package:followupapprefactored/features/modules/client/routine/routine_log/data/models/routine_log_request_body.dart';

import '../../../../../../../core/networking/api_service.dart';
import '../models/routine_log_response.dart';
import 'routine_log_repo.dart';

class RoutineLogRepoImp implements RoutineLogRepo {
  final ApiService _apiService;
  RoutineLogRepoImp(this._apiService);

  @override
  Future<RoutineLogResponse> routineLog(
      RoutineLogRequestBody routineLogRequestBody) async {
    try {
      var response = await _apiService.routineLog(
          routineLogRequestBody: routineLogRequestBody);
      var parsedData = RoutineLogResponse.fromJson(response);
      return parsedData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
