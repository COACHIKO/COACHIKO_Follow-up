import '../models/signup_request_model.dart';
import '../models/signup_response.dart';

abstract class SignupRepo {
  Future<SignUpResponse> register(SignupRequestBody loginRequestBody);
}
