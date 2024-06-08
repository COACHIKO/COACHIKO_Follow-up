// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_insert_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineCrudResponse _$RoutineCrudResponseFromJson(Map<String, dynamic> json) =>
    RoutineCrudResponse(
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$RoutineCrudResponseToJson(
        RoutineCrudResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
