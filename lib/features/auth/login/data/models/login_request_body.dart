import 'package:json_annotation/json_annotation.dart';

part 'login_request_body.g.dart'; // This will be generated

@JsonSerializable()
class LoginRequestBody {
  final String username;
  final String password;
  final String token;

  LoginRequestBody({
    required this.username,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);
}
