class ClientUser {
  /// User Personal Data
  final int id;
  final String firstName;
  final String secondName;
  final String username;
  final String email;
  final String password;
  final String fireBaseToken;
  final int isCoach;
  /// User Subscription Data
  final DateTime subscriptionDate;
  final int isActive;
  final int currentStep;
  final int subscriptionLenth;
  /// Physical User Data
  final DateTime birthdayDate;
  final int genderSelect;
  final int goalSelect;
  final int activitySelect;
  final double weight;
  final double tall;
  final int costSelect;
  final double waist;
  final double neck;
  final double hip;
  final double chest;
  final double arms;
  final double wrist;
  final double targetProtien;
  final double targetCarbohdrate;
  final double targetFat;
  final int tdee;
  final double fatPercentage;
  final String preferedFoods;

  ClientUser({
    required this.id,
    required this.firstName,
    required this.secondName,
    required this.username,
    required this.email,
    required this.password,
    required this.fireBaseToken,
    required this.isCoach,
    required this.isActive,
    required this.subscriptionDate,
    required this.birthdayDate,
    required this.currentStep,
    required this.subscriptionLenth,
    required this.genderSelect,
    required this.goalSelect,
    required this.activitySelect,
    required this.weight,
    required this.tall,
    required this.costSelect,
    required this.waist,
    required this.neck,
    required this.hip,
    required this.chest,
    required this.arms,
    required this.wrist,
    required this.tdee,
    required this.fatPercentage,
    required this.targetProtien,
    required this.targetCarbohdrate,
    required this.targetFat,
    required this.preferedFoods,
  });

  factory ClientUser.fromJson(Map<String, dynamic> json) {
    return ClientUser(

      /// Integer vaLues
      id: json['id'] ?? 0,
      isCoach: json['isCoach'] ?? 0,
      isActive: json['isActive'] ?? 0,
      currentStep: json['current_step'] ?? 0,
      subscriptionLenth: json['subscriptionLenth'] ?? 0,
      genderSelect: json['genderSelect'] ?? 0,
      goalSelect: json['goalSelect'] ?? 0,
      activitySelect: json['activitySelect'] ?? 0,
      costSelect: json['costSelect'] ?? 0,
      tdee: json['tdee'] ?? 0,

      /// Double Values
      weight: double.parse(json['weight'].toString()),
      fatPercentage: double.parse(json['fatPercentage'].toString()),
      targetProtien: double.parse(json['targetProtien'].toString()),
      targetCarbohdrate: double.parse(json['targetCarbohdrate'].toString()),
      targetFat: double.parse(json['targetFat'].toString()),
      tall: double.parse(json['tall'].toString()),
      waist: double.parse(json['waist'].toString()),
      neck: double.parse(json['neck'].toString()),
      hip: double.parse(json['hip'].toString()),
      chest: double.parse(json['chest'].toString()),
      arms: double.parse(json['arms'].toString()),
      wrist: double.parse(json['wrist'].toString()),

      /// String Values
      firstName: json['first_name'] ?? '',
      secondName: json['second_name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      preferedFoods: json['preferedFoods'] ?? "",
      fireBaseToken: json['token'] ?? "",

      /// Date Values
      subscriptionDate: json['subscriptionDate'] != null ? DateTime.parse(json['subscriptionDate']).toLocal() : DateTime.now(),
      birthdayDate: json['birthdayDate'] != null ? DateTime.parse(json['birthdayDate']).toLocal() : DateTime.now(),
    );
  }

}
