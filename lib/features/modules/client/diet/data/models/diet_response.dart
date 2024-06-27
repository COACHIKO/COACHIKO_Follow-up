import 'package:json_annotation/json_annotation.dart';

part 'diet_response.g.dart';

@JsonSerializable()
class DietResponse {
  final String? message;
  final DietData? data;
  final bool? status;
  final int? code;

  DietResponse({
    required this.message,
    required this.data,
    required this.status,
    required this.code,
  });

  factory DietResponse.fromJson(Map<String, dynamic> json) =>
      _$DietResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DietResponseToJson(this);
}

@JsonSerializable()
class DietData {
  @JsonKey(name: 'diet_data')
  final List<DietItem>? dietData;
  final double? tdee;
  @JsonKey(name: 'targetProtien')
  final double? targetProtein;

  DietData({
    required this.dietData,
    required this.tdee,
    required this.targetProtein,
  });

  factory DietData.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class DietItem {
  final int id;
  @JsonKey(name: 'food_id')
  final int foodId;
  late final int quantity;
  final String foodName;
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fats;
  bool isSelected = false;

  DietItem({
    required this.id,
    required this.foodId,
    required this.quantity,
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fats,
  });

  factory DietItem.fromJson(Map<String, dynamic> json) =>
      _$DietItemFromJson(json);

  Map<String, dynamic> toJson() => _$DietItemToJson(this);
}
