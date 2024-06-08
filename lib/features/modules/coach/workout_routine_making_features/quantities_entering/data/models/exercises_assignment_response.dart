import 'package:json_annotation/json_annotation.dart';

part 'exercises_assignment_response.g.dart';

@JsonSerializable()
class ExerciseAssignmentResponse {
  final String status;
  final String message;

  ExerciseAssignmentResponse({
    required this.status,
    required this.message,
  });

  factory ExerciseAssignmentResponse.fromJson(Map<String, dynamic> json) =>
      _$ExerciseAssignmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseAssignmentResponseToJson(this);
}
