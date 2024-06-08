// import 'package:json_annotation/json_annotation.dart';

// part 'food_model.g.dart'; // This is necessary for json_serializable

// @JsonSerializable()
// class Foods {
//   final String id;
//   @JsonKey(name: 'foodName')
//   final String foodName;
//   @JsonKey(name: 'foodName_ar')
//   final String foodNameAr;
//   final String calories;
//   final String protein;
//   final String carbohydrates;
//   final String fats;

//   Foods({
//     required this.id,
//     required this.foodName,
//     required this.foodNameAr,
//     required this.calories,
//     required this.protein,
//     required this.carbohydrates,
//     required this.fats,
//   });

//   // A factory constructor to create a Food instance from a map.
//   factory Foods.fromJson(Map<String, dynamic> json) => _$FoodsFromJson(json);

//   // A method to serialize a Food instance to a map.
//   Map<String, dynamic> toJson() => _$FoodsToJson(this);
// }
