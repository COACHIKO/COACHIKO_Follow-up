// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_log_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineLogRequestBody _$RoutineLogRequestBodyFromJson(
        Map<String, dynamic> json) =>
    RoutineLogRequestBody(
      userId: (json['user_id'] as num).toInt(),
      exerciseId: (json['exercise_id'] as num).toInt(),
      routineId: json['routine_id'] as String,
      weight: json['weight'] as String,
      reps: json['reps'] as String,
    );

Map<String, dynamic> _$RoutineLogRequestBodyToJson(
        RoutineLogRequestBody instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'exercise_id': instance.exerciseId,
      'routine_id': instance.routineId,
      'weight': instance.weight,
      'reps': instance.reps,
    };
