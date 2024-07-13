import 'package:json_annotation/json_annotation.dart';

part 'client_log_history_response.g.dart';

@JsonSerializable()
class Log {
  @JsonKey(name: 'exercise_name')
  final String exerciseName;
  @JsonKey(name: 'routine_name')
  final String routineName;
  @JsonKey(name: 'exercise_id')
  final int exerciseId;
  @JsonKey(name: 'routine_id')
  final int routineId;
  @JsonKey(name: 'exercise_image')
  final String exerciseImage;

  final int weight;
  final int reps;
  @JsonKey(name: 'log_timestamp')
  final String logTimestamp;
  Log(
      {required this.exerciseName,
      required this.routineName,
      required this.exerciseId,
      required this.routineId,
      required this.exerciseImage,
      required this.weight,
      required this.reps,
      required this.logTimestamp});
  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);
  Map<String, dynamic> toJson() => _$LogToJson(this);
}

@JsonSerializable()
class RoutineLog {
  @JsonKey(name: 'routine_name')
  final String routineName;
  final List<Log> logs;
  RoutineLog({required this.routineName, required this.logs});

  factory RoutineLog.fromJson(Map<String, dynamic> json) =>
      _$RoutineLogFromJson(json);
  Map<String, dynamic> toJson() => _$RoutineLogToJson(this);
}

@JsonSerializable()
class MeasureLog {
  final String weight;
  final String waist;
  final String chest;
  final String hip;
  final String arms;
  final String neck;
  final String wrist;
  @JsonKey(name: 'log_timestamp')
  final String logTimestamp;
  MeasureLog(
      {required this.weight,
      required this.waist,
      required this.chest,
      required this.hip,
      required this.arms,
      required this.neck,
      required this.wrist,
      required this.logTimestamp});
  factory MeasureLog.fromJson(Map<String, dynamic> json) =>
      _$MeasureLogFromJson(json);
  Map<String, dynamic> toJson() => _$MeasureLogToJson(this);
}

@JsonSerializable()
class ClientLogsResponseBody {
  final String message;
  final String username;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'second_name')
  final String secondName;
  @JsonKey(name: 'Routine_logs')
  final List<RoutineLog> routineLogs;
  @JsonKey(name: 'Measures_logs')
  final List<MeasureLog> measuresLogs;
  final bool status;
  final int code;
  ClientLogsResponseBody(
      {required this.message,
      required this.username,
      required this.firstName,
      required this.secondName,
      required this.routineLogs,
      required this.measuresLogs,
      required this.status,
      required this.code});
  factory ClientLogsResponseBody.fromJson(Map<String, dynamic> json) =>
      _$ClientLogsResponseBodyFromJson(json);
  Map<String, dynamic> toJson() => _$ClientLogsResponseBodyToJson(this);
}
