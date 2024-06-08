import 'package:json_annotation/json_annotation.dart';

part 'quantity_insertion_request_body.g.dart'; // This is necessary for json_serializable

@JsonSerializable()
class QuantityInsertionRequestBody {
  @JsonKey(name: 'client_id')
  final int clientId;
  @JsonKey(name: 'food_id')
  final String foodId;
  final String quantity;

  QuantityInsertionRequestBody({
    required this.clientId,
    required this.foodId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => _$QuantityInsertionRequestBodyToJson(this);
}
