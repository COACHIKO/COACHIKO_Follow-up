import 'package:followupapprefactored/core/networking/api_service.dart';
import '../models/signup_request_model.dart';
import '../models/signup_response.dart';
import 'signup_repo.dart';

class SignupRepoImp implements SignupRepo {
  final ApiService _apiService;
  SignupRepoImp(this._apiService);
  @override
  Future<SignUpResponse> register(SignupRequestBody signupRequestBody) async {
    try {
      var response =
          await _apiService.register(signupRequestBody: signupRequestBody);

      var parsedData = SignUpResponse.fromJson(response);
      return parsedData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
