import 'package:json_annotation/json_annotation.dart';

part 'exercisesDataBase.g.dart';

@JsonSerializable()
class Exercises {
  @JsonKey(name: 'excersiseID')
  final String exerciseID;
  @JsonKey(name: 'excersiseName')
  final String exerciseName;
  @JsonKey(name: 'targetMuscles')
  final String targetMuscles;
  @JsonKey(name: 'excersiseImage')
  final String exerciseImage;
  @JsonKey(name: 'usedEquipment')
  final String usedEquipment;
  bool isSelected = false;
  Exercises({
    required this.exerciseID,
    required this.exerciseName,
    required this.targetMuscles,
    required this.exerciseImage,
    required this.usedEquipment,
    required this.isSelected,
  });
  factory Exercises.fromJson(Map<String, dynamic> json) =>
      _$ExercisesFromJson(json);
}
