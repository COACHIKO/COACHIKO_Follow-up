import 'package:json_annotation/json_annotation.dart';

part 'clients_response.g.dart';

@JsonSerializable()
class ClientsDataResponse {
  final String status;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  final String message;
  @JsonKey(name: 'data')
  final List<ClientData>? clients;

  ClientsDataResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.clients,
  });

  factory ClientsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ClientsDataResponseFromJson(json);
}

@JsonSerializable()
class ClientData {
  /// User Personal Data
  final int? id;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'second_name')
  final String? secondName;
  final String? username;
  final String? email;
  final String? password;
  @JsonKey(name: 'token')
  final String? fireBaseToken;
  @JsonKey(name: 'RelatedtoCoachID')
  final int? coachId;

  /// User Subscription Data
  final DateTime? subscriptionDate;
  final int? isActive;
  @JsonKey(name: 'current_step')
  final int? currentStep;
  @JsonKey(name: 'subscriptionLenth')
  final int? subscriptionLength;

  /// Physical User Data
  final DateTime? birthdayDate;
  final int? genderSelect;
  final int? goalSelect;
  final int? activitySelect;
  final double? weight;
  final double? tall;
  final int? costSelect;
  final double? waist;
  final double? neck;
  final double? hip;
  final double? chest;
  final double? arms;
  final double? wrist;
  final double? targetProtien;
  @JsonKey(name: 'targetCarbohdrate')
  final double? targetCarbohydrate;
  final double? targetFat;
  final int? tdee;
  final double? fatPercentage;
  @JsonKey(name: 'preferedFoods')
  final String? preferredFoods;

  ClientData({
    this.id,
    this.firstName,
    this.secondName,
    this.username,
    this.email,
    this.password,
    this.fireBaseToken,
    this.coachId,
    this.isActive,
    this.subscriptionDate,
    this.birthdayDate,
    this.currentStep,
    this.subscriptionLength,
    this.genderSelect,
    this.goalSelect,
    this.activitySelect,
    this.weight,
    this.tall,
    this.costSelect,
    this.waist,
    this.neck,
    this.hip,
    this.chest,
    this.arms,
    this.wrist,
    this.tdee,
    this.fatPercentage,
    this.targetProtien,
    this.targetCarbohydrate,
    this.targetFat,
    this.preferredFoods,
  });

  factory ClientData.fromJson(Map<String, dynamic> json) =>
      _$ClientDataFromJson(json);
}
