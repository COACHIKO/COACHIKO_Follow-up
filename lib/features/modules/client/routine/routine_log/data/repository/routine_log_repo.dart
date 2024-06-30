import 'package:followupapprefactored/features/modules/client/routine/routine_log/data/models/routine_log_request_body.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_log/data/models/routine_log_response.dart';

abstract class RoutineLogRepo {
  Future<RoutineLogResponse> routineLog(
      RoutineLogRequestBody routineLogRequestBody);
}
