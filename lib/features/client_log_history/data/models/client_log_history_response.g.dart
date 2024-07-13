// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_log_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Log _$LogFromJson(Map<String, dynamic> json) => Log(
      exerciseName: json['exercise_name'] as String,
      routineName: json['routine_name'] as String,
      exerciseId: (json['exercise_id'] as num).toInt(),
      routineId: (json['routine_id'] as num).toInt(),
      exerciseImage: json['exercise_image'] as String,
      weight: (json['weight'] as num).toInt(),
      reps: (json['reps'] as num).toInt(),
      logTimestamp: json['log_timestamp'] as String,
    );

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'exercise_name': instance.exerciseName,
      'routine_name': instance.routineName,
      'exercise_id': instance.exerciseId,
      'routine_id': instance.routineId,
      'exercise_image': instance.exerciseImage,
      'weight': instance.weight,
      'reps': instance.reps,
      'log_timestamp': instance.logTimestamp,
    };

RoutineLog _$RoutineLogFromJson(Map<String, dynamic> json) => RoutineLog(
      routineName: json['routine_name'] as String,
      logs: (json['logs'] as List<dynamic>)
          .map((e) => Log.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoutineLogToJson(RoutineLog instance) =>
    <String, dynamic>{
      'routine_name': instance.routineName,
      'logs': instance.logs,
    };

MeasureLog _$MeasureLogFromJson(Map<String, dynamic> json) => MeasureLog(
      weight: json['weight'] as String,
      waist: json['waist'] as String,
      chest: json['chest'] as String,
      hip: json['hip'] as String,
      arms: json['arms'] as String,
      neck: json['neck'] as String,
      wrist: json['wrist'] as String,
      logTimestamp: json['log_timestamp'] as String,
    );

Map<String, dynamic> _$MeasureLogToJson(MeasureLog instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'waist': instance.waist,
      'chest': instance.chest,
      'hip': instance.hip,
      'arms': instance.arms,
      'neck': instance.neck,
      'wrist': instance.wrist,
      'log_timestamp': instance.logTimestamp,
    };

ClientLogsResponseBody _$ClientLogsResponseBodyFromJson(
        Map<String, dynamic> json) =>
    ClientLogsResponseBody(
      message: json['message'] as String,
      username: json['username'] as String,
      firstName: json['first_name'] as String,
      secondName: json['second_name'] as String,
      routineLogs: (json['Routine_logs'] as List<dynamic>)
          .map((e) => RoutineLog.fromJson(e as Map<String, dynamic>))
          .toList(),
      measuresLogs: (json['Measures_logs'] as List<dynamic>)
          .map((e) => MeasureLog.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as bool,
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$ClientLogsResponseBodyToJson(
        ClientLogsResponseBody instance) =>
    <String, dynamic>{
      'message': instance.message,
      'username': instance.username,
      'first_name': instance.firstName,
      'second_name': instance.secondName,
      'Routine_logs': instance.routineLogs,
      'Measures_logs': instance.measuresLogs,
      'status': instance.status,
      'code': instance.code,
    };
