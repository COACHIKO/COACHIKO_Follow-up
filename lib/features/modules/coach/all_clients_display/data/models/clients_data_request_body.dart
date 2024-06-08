import 'package:json_annotation/json_annotation.dart';

part 'clients_data_request_body.g.dart';

@JsonSerializable()
class ClientsDataRequestBody {
  @JsonKey(name: 'id')
  final String? user;

  ClientsDataRequestBody({
    required this.user,
  });

  Map<String, dynamic> toJson() => _$ClientsDataRequestBodyToJson(this);
}
