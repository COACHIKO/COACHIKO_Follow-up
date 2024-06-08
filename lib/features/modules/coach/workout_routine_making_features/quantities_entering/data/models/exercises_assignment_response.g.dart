// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_assignment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseAssignmentResponse _$ExerciseAssignmentResponseFromJson(
        Map<String, dynamic> json) =>
    ExerciseAssignmentResponse(
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ExerciseAssignmentResponseToJson(
        ExerciseAssignmentResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
