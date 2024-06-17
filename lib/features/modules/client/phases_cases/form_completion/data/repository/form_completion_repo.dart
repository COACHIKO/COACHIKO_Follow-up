import '../models/form_completion_request_body.dart';
import '../models/form_completion_response.dart';

abstract class FormCompletionRepo {
  Future<FormCompletionResponse> completeForm(
      FormCompletionRequestBody formInsertionRequestBody);
}
