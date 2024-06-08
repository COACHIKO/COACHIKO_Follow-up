class SignupRequestBody {
  final String username;
  final String password;
  final String email;
  final String firstName;
  final String secondName;
  final int isCoach;
  final String? coachUserName;

  SignupRequestBody({
    required this.username,
    required this.password,
    required this.email,
    required this.firstName,
    required this.secondName,
    required this.isCoach,
    this.coachUserName,
  });

  Map<String, String> toJson() {
    return {
      "username": username,
      "password": password,
      "email": email,
      "first_name": firstName,
      "second_name": secondName,
      "coach_user_name": coachUserName.toString(),
      "isCoach": isCoach == 0 ? "Client" : "Coach",
    };
  }
}
