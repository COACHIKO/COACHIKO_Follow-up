// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_completion_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormCompletionRequestBody _$FormCompletionRequestBodyFromJson(
        Map<String, dynamic> json) =>
    FormCompletionRequestBody(
      id: (json['id'] as num).toInt(),
      preferedFoods: json['preferedFoods'] as String,
      genderSelect: (json['genderSelect'] as num).toInt(),
      goalSelect: (json['goalSelect'] as num).toInt(),
      activitySelect: (json['activitySelect'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      tall: (json['tall'] as num).toDouble(),
      costSelect: (json['costSelect'] as num).toInt(),
      waist: (json['waist'] as num).toDouble(),
      neck: (json['neck'] as num).toDouble(),
      hip: (json['hip'] as num).toDouble(),
      chest: (json['chest'] as num).toDouble(),
      arms: (json['arms'] as num).toDouble(),
      wrist: (json['wrist'] as num).toDouble(),
      tdee: (json['tdee'] as num).toInt(),
      fatPercentage: (json['fatPercentage'] as num).toDouble(),
      targetProtien: (json['targetProtien'] as num).toInt(),
      targetCarbohdrate: (json['targetCarbohdrate'] as num).toInt(),
      targetFat: (json['targetFat'] as num).toInt(),
      currentStep: (json['current_step'] as num).toInt(),
      birthdayDate: DateTime.parse(json['birthdayDate'] as String),
    );

Map<String, dynamic> _$FormCompletionRequestBodyToJson(
        FormCompletionRequestBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'preferedFoods': instance.preferedFoods,
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
      'tdee': instance.tdee,
      'fatPercentage': instance.fatPercentage,
      'targetProtien': instance.targetProtien,
      'targetCarbohdrate': instance.targetCarbohdrate,
      'targetFat': instance.targetFat,
      'current_step': instance.currentStep,
      'birthdayDate': instance.birthdayDate.toIso8601String(),
    };
