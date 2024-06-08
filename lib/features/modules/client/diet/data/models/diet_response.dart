import 'package:json_annotation/json_annotation.dart';

part 'diet_response.g.dart';

@JsonSerializable()
class DietResponse {
  final String? message;
  @JsonKey(name: 'data')
  final List<DietItem>? diet;
  final bool? status;
  final int? code;

  DietResponse({
    required this.message,
    required this.diet,
    required this.status,
    required this.code,
  });

  factory DietResponse.fromJson(Map<String, dynamic> json) =>
      _$DietResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DietResponseToJson(this);
}

@JsonSerializable()
class DietItem {
  final int id;
  @JsonKey(name: 'food_id')
  final int foodId;
  final int quantity;
  final String foodName;
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fats;
  @JsonKey(name: 'targetProtien')
  final double targetProtein;
  @JsonKey(name: 'targetCarbohdrate')
  final double targetCarbohydrate;
  @JsonKey(name: 'targetFat')
  final double targetFat;
  final double tdee;

  DietItem({
    required this.id,
    required this.foodId,
    required this.quantity,
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fats,
    required this.targetProtein,
    required this.targetCarbohydrate,
    required this.targetFat,
    required this.tdee,
  });

  factory DietItem.fromJson(Map<String, dynamic> json) =>
      _$DietItemFromJson(json);

  Map<String, dynamic> toJson() => _$DietItemToJson(this);
}
