import 'package:json_annotation/json_annotation.dart';

part 'form_completion_response.g.dart'; // This is necessary for json_serializable

@JsonSerializable()
class FormCompletionResponse {
  final String status;
  final String message;
  FormCompletionResponse({
    required this.status,
    required this.message,
  });
  factory FormCompletionResponse.fromJson(Map<String, dynamic> json) =>
      _$FormCompletionResponseFromJson(json);
}
