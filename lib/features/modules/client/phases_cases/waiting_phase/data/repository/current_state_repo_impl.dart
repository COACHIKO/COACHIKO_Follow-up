import '../../../../../../../core/networking/api_service.dart';

import '../models/current_stage_request_body.dart';
import '../models/current_stage_response.dart';
import 'current_state_repo.dart';

class CurrentStateRepoImpl implements CurrentStateRepo {
  final ApiService _apiService;
  CurrentStateRepoImpl(this._apiService);

  @override
  Future<CurrentStageResponse> getCurrentStage(
      CurrentStageRequestBody currentStageRequestBody) async {
    try {
      var response = await _apiService.getCurrentStage(
          currentStageRequestBody: currentStageRequestBody);

      var parsedData = CurrentStageResponse.fromJson(response);
      print(parsedData);

      return parsedData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
