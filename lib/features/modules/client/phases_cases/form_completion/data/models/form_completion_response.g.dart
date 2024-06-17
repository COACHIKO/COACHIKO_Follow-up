// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_completion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormCompletionResponse _$FormCompletionResponseFromJson(
        Map<String, dynamic> json) =>
    FormCompletionResponse(
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$FormCompletionResponseToJson(
        FormCompletionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
