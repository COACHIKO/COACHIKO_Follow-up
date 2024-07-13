import '../models/client_log_history_request_body.dart';
import '../models/client_log_history_response.dart';

abstract class GetClientLogHistoryRepo {
  Future<ClientLogsResponseBody> getLogsHistory(
      ClientLogsRequestBody clientLogsRequestBody);
}
