import 'package:json_annotation/json_annotation.dart';

part 'quantity_insertion_response.g.dart'; // This is necessary for json_serializable

@JsonSerializable()
class QuantityInsertionResponse {
  final String message;

  QuantityInsertionResponse({
    required this.message,
  });
  factory QuantityInsertionResponse.fromJson(Map<String, dynamic> json) =>
      _$QuantityInsertionResponseFromJson(json);
}
