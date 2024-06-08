import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart'; // This will be generated

@JsonSerializable()
class SignUpResponse {
  final String status;
  final String message;
  final int code;

  SignUpResponse({
    required this.status,
    required this.message,
    required this.code,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}
