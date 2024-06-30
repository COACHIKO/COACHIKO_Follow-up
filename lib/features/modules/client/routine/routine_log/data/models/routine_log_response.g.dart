// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_log_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineLogResponse _$RoutineLogResponseFromJson(Map<String, dynamic> json) =>
    RoutineLogResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$RoutineLogResponseToJson(RoutineLogResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
