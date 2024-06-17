import '../../../../../../../../../../../core/networking/api_service.dart';
import '../models/form_completion_request_body.dart';
import '../models/form_completion_response.dart';
import 'form_completion_repo.dart';

class FormCompletionRepoImp implements FormCompletionRepo {
  final ApiService _apiService;
  FormCompletionRepoImp(this._apiService);

  @override
  Future<FormCompletionResponse> completeForm(
      FormCompletionRequestBody formCompletionRequestBody) async {
    try {
      var response = await _apiService.completeForm(
          formCompletionRequestBody: formCompletionRequestBody);
      var parsedData = FormCompletionResponse.fromJson(response);
      return parsedData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
