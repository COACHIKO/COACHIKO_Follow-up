import 'package:json_annotation/json_annotation.dart';

part 'routine_crud_request_body.g.dart';

@JsonSerializable()
class RoutineInsertRequestBody {
  @JsonKey(name: 'routinename')
  String routineName;
  @JsonKey(name: 'user_id')
  int userId;

  RoutineInsertRequestBody({required this.routineName, required this.userId});

  Map<String, dynamic> toJson() => _$RoutineInsertRequestBodyToJson(this);
}

@JsonSerializable()
class RoutineUpdateRequestBody {
  @JsonKey(name: 'routine_id')
  int routineId;
  @JsonKey(name: 'new_routinename')
  String routineName;

  RoutineUpdateRequestBody(
      {required this.routineName, required this.routineId});

  Map<String, dynamic> toJson() => _$RoutineUpdateRequestBodyToJson(this);
}

@JsonSerializable()
class RoutineDeleteRequestBody {
  @JsonKey(name: 'routine_id')
  int routineId;

  RoutineDeleteRequestBody({
    required this.routineId,
  });

  Map<String, dynamic> toJson() => _$RoutineDeleteRequestBodyToJson(this);
}
