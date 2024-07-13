import 'package:json_annotation/json_annotation.dart';

part 'client_log_history_request_body.g.dart';

@JsonSerializable()
class ClientLogsRequestBody {
  final String user;

  ClientLogsRequestBody({
    required this.user,
  });

  Map<String, dynamic> toJson() => _$ClientLogsRequestBodyToJson(this);
}
