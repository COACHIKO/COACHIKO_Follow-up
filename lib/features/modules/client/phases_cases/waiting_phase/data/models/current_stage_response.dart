import 'package:json_annotation/json_annotation.dart';

part 'current_stage_response.g.dart'; // This is necessary for json_serializable

@JsonSerializable()
class CurrentStageResponse {
  final String status;
  @JsonKey(name: 'current_step')
  final int currentStep;
  @JsonKey(name: 'coach_token')
  final String coachToken;

  CurrentStageResponse(
      {required this.status,
      required this.currentStep,
      required this.coachToken});
  factory CurrentStageResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentStageResponseFromJson(json);
}
