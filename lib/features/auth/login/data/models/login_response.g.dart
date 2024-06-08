// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      userData: json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.userData,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: (json['id'] as num).toInt(),
      firstName: json['first_name'] as String,
      secondName: json['second_name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      isCoach: json['isCoach'] as String,
      relatedToCoachID: (json['RelatedtoCoachID'] as num).toInt(),
      currentStep: (json['current_step'] as num).toInt(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'second_name': instance.secondName,
      'username': instance.username,
      'email': instance.email,
      'token': instance.token,
      'isCoach': instance.isCoach,
      'RelatedtoCoachID': instance.relatedToCoachID,
      'current_step': instance.currentStep,
    };
