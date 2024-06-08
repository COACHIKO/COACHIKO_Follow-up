// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DietResponse _$DietResponseFromJson(Map<String, dynamic> json) => DietResponse(
      message: json['message'] as String?,
      diet: (json['data'] as List<dynamic>?)
          ?.map((e) => DietItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DietResponseToJson(DietResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.diet,
      'status': instance.status,
      'code': instance.code,
    };

DietItem _$DietItemFromJson(Map<String, dynamic> json) => DietItem(
      id: (json['id'] as num).toInt(),
      foodId: (json['food_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      foodName: json['foodName'] as String,
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbohydrates: (json['carbohydrates'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      targetProtein: (json['targetProtien'] as num).toDouble(),
      targetCarbohydrate: (json['targetCarbohdrate'] as num).toDouble(),
      targetFat: (json['targetFat'] as num).toDouble(),
      tdee: (json['tdee'] as num).toDouble(),
    );

Map<String, dynamic> _$DietItemToJson(DietItem instance) => <String, dynamic>{
      'id': instance.id,
      'food_id': instance.foodId,
      'quantity': instance.quantity,
      'foodName': instance.foodName,
      'calories': instance.calories,
      'protein': instance.protein,
      'carbohydrates': instance.carbohydrates,
      'fats': instance.fats,
      'targetProtien': instance.targetProtein,
      'targetCarbohdrate': instance.targetCarbohydrate,
      'targetFat': instance.targetFat,
      'tdee': instance.tdee,
    };
