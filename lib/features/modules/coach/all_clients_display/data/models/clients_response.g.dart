// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientsDataResponse _$ClientsDataResponseFromJson(Map<String, dynamic> json) =>
    ClientsDataResponse(
      status: json['status'] as String,
      statusCode: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String,
      clients: (json['data'] as List<dynamic>?)
          ?.map((e) => ClientData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClientsDataResponseToJson(
        ClientsDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.clients,
    };

ClientData _$ClientDataFromJson(Map<String, dynamic> json) => ClientData(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      secondName: json['second_name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      fireBaseToken: json['token'] as String?,
      coachId: (json['RelatedtoCoachID'] as num?)?.toInt(),
      isActive: (json['isActive'] as num?)?.toInt(),
      subscriptionDate: json['subscriptionDate'] == null
          ? null
          : DateTime.parse(json['subscriptionDate'] as String),
      birthdayDate: json['birthdayDate'] == null
          ? null
          : DateTime.parse(json['birthdayDate'] as String),
      currentStep: (json['current_step'] as num?)?.toInt(),
      subscriptionLength: (json['subscriptionLenth'] as num?)?.toInt(),
      genderSelect: (json['genderSelect'] as num?)?.toInt(),
      goalSelect: (json['goalSelect'] as num?)?.toInt(),
      activitySelect: (json['activitySelect'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toDouble(),
      tall: (json['tall'] as num?)?.toDouble(),
      costSelect: (json['costSelect'] as num?)?.toInt(),
      waist: (json['waist'] as num?)?.toDouble(),
      neck: (json['neck'] as num?)?.toDouble(),
      hip: (json['hip'] as num?)?.toDouble(),
      chest: (json['chest'] as num?)?.toDouble(),
      arms: (json['arms'] as num?)?.toDouble(),
      wrist: (json['wrist'] as num?)?.toDouble(),
      tdee: (json['tdee'] as num?)?.toInt(),
      fatPercentage: (json['fatPercentage'] as num?)?.toDouble(),
      targetProtien: (json['targetProtien'] as num?)?.toDouble(),
      targetCarbohydrate: (json['targetCarbohdrate'] as num?)?.toDouble(),
      targetFat: (json['targetFat'] as num?)?.toDouble(),
      preferredFoods: json['preferedFoods'] as String?,
    );

Map<String, dynamic> _$ClientDataToJson(ClientData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'second_name': instance.secondName,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'token': instance.fireBaseToken,
      'RelatedtoCoachID': instance.coachId,
      'subscriptionDate': instance.subscriptionDate?.toIso8601String(),
      'isActive': instance.isActive,
      'current_step': instance.currentStep,
      'subscriptionLenth': instance.subscriptionLength,
      'birthdayDate': instance.birthdayDate?.toIso8601String(),
      'genderSelect': instance.genderSelect,
      'goalSelect': instance.goalSelect,
      'activitySelect': instance.activitySelect,
      'weight': instance.weight,
      'tall': instance.tall,
      'costSelect': instance.costSelect,
      'waist': instance.waist,
      'neck': instance.neck,
      'hip': instance.hip,
      'chest': instance.chest,
      'arms': instance.arms,
      'wrist': instance.wrist,
      'targetProtien': instance.targetProtien,
      'targetCarbohdrate': instance.targetCarbohydrate,
      'targetFat': instance.targetFat,
      'tdee': instance.tdee,
      'fatPercentage': instance.fatPercentage,
      'preferedFoods': instance.preferredFoods,
    };
