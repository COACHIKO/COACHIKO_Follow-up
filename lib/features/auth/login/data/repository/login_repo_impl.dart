import 'package:followupapprefactored/features/auth/login/data/models/login_response.dart';
import '../../../../../core/networking/api_service.dart';
import '../models/login_request_body.dart';
import 'login_repo.dart';

class LoginRepoImp implements LoginRepo {
  final ApiService _apiService;
  LoginRepoImp(this._apiService);

  @override
  Future<LoginResponse> login(
      LoginRequestBody loginRequestBody, bool rememberMe) async {
    var response = await _apiService.login(loginRequestBody: loginRequestBody);
    var parsedData = LoginResponse.fromJson(response);
    print(parsedData.userData);
    return parsedData;
  }
}
