// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quantity_insertion_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuantityInsertionRequestBody _$QuantityInsertionRequestBodyFromJson(
        Map<String, dynamic> json) =>
    QuantityInsertionRequestBody(
      clientId: (json['client_id'] as num).toInt(),
      foodId: json['food_id'] as String,
      quantity: json['quantity'] as String,
    );

Map<String, dynamic> _$QuantityInsertionRequestBodyToJson(
        QuantityInsertionRequestBody instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'food_id': instance.foodId,
      'quantity': instance.quantity,
    };
