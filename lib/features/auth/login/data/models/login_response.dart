import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart'; // This will be generated

@JsonSerializable()
class LoginResponse {
  final String status;
  final String message;
  @JsonKey(name: 'data')
  final UserData? userData;

  LoginResponse({
    required this.status,
    required this.message,
    required this.userData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class UserData {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'second_name')
  final String secondName;
  final String username;
  final String email;
  final String token;
  @JsonKey(name: 'isCoach')
  final String isCoach;
  @JsonKey(name: 'RelatedtoCoachID')
  final int relatedToCoachID;
  @JsonKey(name: 'current_step')
  final int currentStep;

  UserData({
    required this.id,
    required this.firstName,
    required this.secondName,
    required this.username,
    required this.email,
    required this.token,
    required this.isCoach,
    required this.relatedToCoachID,
    required this.currentStep,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
