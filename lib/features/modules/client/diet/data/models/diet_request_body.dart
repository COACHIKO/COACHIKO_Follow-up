import 'package:json_annotation/json_annotation.dart';

part 'diet_request_body.g.dart';

@JsonSerializable()
class DietRequestBody {
  @JsonKey(name: 'client_id')
  final String clientId;

  DietRequestBody({
    required this.clientId,
  });

  Map<String, dynamic> toJson() => _$DietRequestBodyToJson(this);
}
