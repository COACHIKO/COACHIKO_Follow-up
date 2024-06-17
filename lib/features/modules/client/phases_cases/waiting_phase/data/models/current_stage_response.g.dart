// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_stage_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentStageResponse _$CurrentStageResponseFromJson(
        Map<String, dynamic> json) =>
    CurrentStageResponse(
      status: json['status'] as String,
      currentStep: (json['current_step'] as num).toInt(),
      coachToken: json['coach_token'] as String,
    );

Map<String, dynamic> _$CurrentStageResponseToJson(
        CurrentStageResponse instance) =>
    <String, dynamic>{
      'current_step': instance.currentStep,
      'coach_token': instance.coachToken,
    };
