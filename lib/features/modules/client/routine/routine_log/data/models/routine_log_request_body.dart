import 'package:json_annotation/json_annotation.dart';

part 'routine_log_request_body.g.dart';

@JsonSerializable()
class RoutineLogRequestBody {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'exercise_id')
  final int exerciseId;

  final String weight;
  final String reps;

  RoutineLogRequestBody({
    required this.userId,
    required this.exerciseId,
    required this.weight,
    required this.reps,
  });

  factory RoutineLogRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RoutineLogRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineLogRequestBodyToJson(this);
}
