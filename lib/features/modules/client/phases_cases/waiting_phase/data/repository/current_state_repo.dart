import '../models/current_stage_request_body.dart';
import '../models/current_stage_response.dart';

abstract class CurrentStateRepo {
  Future<CurrentStageResponse> getCurrentStage(
      CurrentStageRequestBody currentStageRequestBody);
}
