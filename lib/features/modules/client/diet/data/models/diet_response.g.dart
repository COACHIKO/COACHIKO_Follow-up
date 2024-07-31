// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DietResponse _$DietResponseFromJson(Map<String, dynamic> json) => DietResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DietData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DietResponseToJson(DietResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'status': instance.status,
      'code': instance.code,
    };

DietData _$DietDataFromJson(Map<String, dynamic> json) => DietData(
      dietData: (json['diet_data'] as List<dynamic>?)
          ?.map((e) => DietItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      tdee: (json['tdee'] as num?)?.toDouble(),
      targetProtein: (json['targetProtien'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DietDataToJson(DietData instance) => <String, dynamic>{
      'diet_data': instance.dietData,
      'tdee': instance.tdee,
      'targetProtien': instance.targetProtein,
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
    )..isSelected = json['isSelected'] as bool;

Map<String, dynamic> _$DietItemToJson(DietItem instance) => <String, dynamic>{
      'id': instance.id,
      'food_id': instance.foodId,
      'quantity': instance.quantity,
      'foodName': instance.foodName,
      'calories': instance.calories,
      'protein': instance.protein,
      'carbohydrates': instance.carbohydrates,
      'fats': instance.fats,
      'isSelected': instance.isSelected,
    };
