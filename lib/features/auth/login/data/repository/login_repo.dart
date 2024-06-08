import 'package:followupapprefactored/features/auth/login/data/models/login_response.dart';
import '../models/login_request_body.dart';

abstract class LoginRepo {
  Future<LoginResponse> login(
      LoginRequestBody loginRequestBody, bool rememberMe);
}
