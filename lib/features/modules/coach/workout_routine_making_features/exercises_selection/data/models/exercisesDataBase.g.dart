// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercisesDataBase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercises _$ExercisesFromJson(Map<String, dynamic> json) => Exercises(
      exerciseID: json['excersiseID'] as String,
      exerciseName: json['excersiseName'] as String,
      targetMuscles: json['targetMuscles'] as String,
      exerciseImage: json['excersiseImage'] as String,
      usedEquipment: json['usedEquipment'] as String,
      isSelected: false,
    );

Map<String, dynamic> _$ExercisesToJson(Exercises instance) => <String, dynamic>{
      'excersiseID': instance.exerciseID,
      'excersiseName': instance.exerciseName,
      'targetMuscles': instance.targetMuscles,
      'excersiseImage': instance.exerciseImage,
      'usedEquipment': instance.usedEquipment,
      'isSelected': false,
    };
