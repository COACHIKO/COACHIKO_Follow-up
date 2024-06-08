// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_assignment_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseAssignmentRequestBody _$ExerciseAssignmentRequestBodyFromJson(
        Map<String, dynamic> json) =>
    ExerciseAssignmentRequestBody(
      userId: json['user_id'] as String,
      routineId: json['routineId'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map(
              (e) => ExerciseInsertionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExerciseAssignmentRequestBodyToJson(
        ExerciseAssignmentRequestBody instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'routineId': instance.routineId,
      'exercises': instance.exercises,
    };

ExerciseInsertionModel _$ExerciseInsertionModelFromJson(
        Map<String, dynamic> json) =>
    ExerciseInsertionModel(
      exerciseId: json['exercise_id'] as String,
      sets: json['sets'] as String,
      reps: json['reps'] as String,
      rir: json['rir'] as String,
      rest: json['rest'] as String,
    );

Map<String, dynamic> _$ExerciseInsertionModelToJson(
        ExerciseInsertionModel instance) =>
    <String, dynamic>{
      'exercise_id': instance.exerciseId,
      'sets': instance.sets,
      'reps': instance.reps,
      'rir': instance.rir,
      'rest': instance.rest,
    };
