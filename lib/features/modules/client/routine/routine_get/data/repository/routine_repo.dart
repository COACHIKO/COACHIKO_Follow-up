import '../models/routine_request_body.dart';
import '../models/routine_response.dart';

abstract class RoutineRepo {
  Future<List<Routine>> getRoutine(RoutineRequestBody routineRequestBody);
}
