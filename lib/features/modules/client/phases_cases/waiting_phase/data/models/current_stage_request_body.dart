import 'package:json_annotation/json_annotation.dart';

part 'current_stage_request_body.g.dart'; // This will be generated

@JsonSerializable()
class CurrentStageRequestBody {
  final int id;

  CurrentStageRequestBody({
    required this.id,
  });

  Map<String, dynamic> toJson() => _$CurrentStageRequestBodyToJson(this);
}
