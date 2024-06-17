import 'package:json_annotation/json_annotation.dart';

part 'form_completion_request_body.g.dart';

@JsonSerializable()
class FormCompletionRequestBody {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'preferedFoods')
  final String preferedFoods;
  @JsonKey(name: 'genderSelect')
  final int genderSelect;
  @JsonKey(name: 'goalSelect')
  final int goalSelect;
  @JsonKey(name: 'activitySelect')
  final int activitySelect;
  @JsonKey(name: 'weight')
  final double weight;
  @JsonKey(name: 'tall')
  final double tall;
  @JsonKey(name: 'costSelect')
  final int costSelect;
  @JsonKey(name: 'waist')
  final double waist;
  @JsonKey(name: 'neck')
  final double neck;
  @JsonKey(name: 'hip')
  final double hip;
  @JsonKey(name: 'chest')
  final double chest;
  @JsonKey(name: 'arms')
  final double arms;
  @JsonKey(name: 'wrist')
  final double wrist;
  @JsonKey(name: 'tdee')
  final int tdee;
  @JsonKey(name: 'fatPercentage')
  final double fatPercentage;
  @JsonKey(name: 'targetProtien')
  final int targetProtien;
  @JsonKey(name: 'targetCarbohdrate')
  final int targetCarbohdrate;
  @JsonKey(name: 'targetFat')
  final int targetFat;
  @JsonKey(name: 'current_step')
  final int currentStep;
  @JsonKey(name: 'birthdayDate')
  final DateTime birthdayDate;

  FormCompletionRequestBody({
    required this.id,
    required this.preferedFoods,
    required this.genderSelect,
    required this.goalSelect,
    required this.activitySelect,
    required this.weight,
    required this.tall,
    required this.costSelect,
    required this.waist,
    required this.neck,
    required this.hip,
    required this.chest,
    required this.arms,
    required this.wrist,
    required this.tdee,
    required this.fatPercentage,
    required this.targetProtien,
    required this.targetCarbohdrate,
    required this.targetFat,
    required this.currentStep,
    required this.birthdayDate,
  });

  factory FormCompletionRequestBody.fromJson(Map<String, dynamic> json) =>
      _$FormCompletionRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$FormCompletionRequestBodyToJson(this);
}
