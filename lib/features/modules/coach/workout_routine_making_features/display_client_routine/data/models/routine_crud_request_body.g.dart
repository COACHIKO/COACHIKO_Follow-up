// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_crud_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineInsertRequestBody _$RoutineInsertRequestBodyFromJson(
        Map<String, dynamic> json) =>
    RoutineInsertRequestBody(
      routineName: json['routinename'] as String,
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$RoutineInsertRequestBodyToJson(
        RoutineInsertRequestBody instance) =>
    <String, dynamic>{
      'routinename': instance.routineName,
      'user_id': instance.userId,
    };

RoutineUpdateRequestBody _$RoutineUpdateRequestBodyFromJson(
        Map<String, dynamic> json) =>
    RoutineUpdateRequestBody(
      routineName: json['new_routinename'] as String,
      routineId: (json['routine_id'] as num).toInt(),
    );

Map<String, dynamic> _$RoutineUpdateRequestBodyToJson(
        RoutineUpdateRequestBody instance) =>
    <String, dynamic>{
      'routine_id': instance.routineId,
      'new_routinename': instance.routineName,
    };

RoutineDeleteRequestBody _$RoutineDeleteRequestBodyFromJson(
        Map<String, dynamic> json) =>
    RoutineDeleteRequestBody(
      routineId: (json['routine_id'] as num).toInt(),
    );

Map<String, dynamic> _$RoutineDeleteRequestBodyToJson(
        RoutineDeleteRequestBody instance) =>
    <String, dynamic>{
      'routine_id': instance.routineId,
    };
