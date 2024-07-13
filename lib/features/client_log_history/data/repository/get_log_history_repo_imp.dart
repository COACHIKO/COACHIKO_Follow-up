import 'package:followupapprefactored/features/client_log_history/data/repository/get_log_history_repo.dart';
import '../../../../../../core/networking/api_service.dart';
import '../models/client_log_history_request_body.dart';
import '../models/client_log_history_response.dart';

class GetLogHistoryRepoImp implements GetClientLogHistoryRepo {
  final ApiService _apiService;
  GetLogHistoryRepoImp(this._apiService);

  @override
  Future<ClientLogsResponseBody> getLogsHistory(
      ClientLogsRequestBody clientLogsRequestBody) async {
    try {
      var response = await _apiService.getLogsHistory(
          clientLogsRequestBody: clientLogsRequestBody);
      var parsedData = ClientLogsResponseBody.fromJson(response);
      return parsedData;
    } catch (e) {
      throw Exception('Failed to load log data');
    }
  }
}
