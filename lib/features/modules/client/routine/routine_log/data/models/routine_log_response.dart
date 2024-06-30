import 'package:json_annotation/json_annotation.dart';

part 'routine_log_response.g.dart';

@JsonSerializable()
class RoutineLogResponse {
  final bool status;
  final String message;

  RoutineLogResponse({
    required this.status,
    required this.message,
  });

  factory RoutineLogResponse.fromJson(Map<String, dynamic> json) =>
      _$RoutineLogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineLogResponseToJson(this);
}
