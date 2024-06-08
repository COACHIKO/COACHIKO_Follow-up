import 'package:json_annotation/json_annotation.dart';

part 'routine_request_body.g.dart'; // This will be generated

@JsonSerializable()
class RoutineRequestBody {
  final String user;

  RoutineRequestBody({
    required this.user,
  });

  Map<String, dynamic> toJson() => _$RoutineRequestBodyToJson(this);
}
