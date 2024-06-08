import 'package:json_annotation/json_annotation.dart';

part 'exercises_assignment_request_body.g.dart';

@JsonSerializable()
class ExerciseAssignmentRequestBody {
  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'routineId')
  final String routineId;

  @JsonKey(name: 'exercises')
  final List<ExerciseInsertionModel> exercises;

  ExerciseAssignmentRequestBody({
    required this.userId,
    required this.routineId,
    required this.exercises,
  });

  factory ExerciseAssignmentRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ExerciseAssignmentRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseAssignmentRequestBodyToJson(this);
}

@JsonSerializable()
class ExerciseInsertionModel {
  @JsonKey(name: 'exercise_id')
  final String exerciseId;
  final String sets;
  final String reps;
  final String rir;
  final String rest;

  ExerciseInsertionModel({
    required this.exerciseId,
    required this.sets,
    required this.reps,
    required this.rir,
    required this.rest,
  });

  factory ExerciseInsertionModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseInsertionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseInsertionModelToJson(this);
}
