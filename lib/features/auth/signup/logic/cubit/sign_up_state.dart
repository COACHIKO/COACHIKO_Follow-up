
class SignUpState {
  final bool isCoach;
  final String firstName;
  final String secondName;
  final String username;
  final String email;
  final String password;
  final String coachUserName;

  SignUpState({
    this.isCoach = false,
    this.firstName = '',
    this.secondName = '',
    this.username = '',
    this.email = '',
    this.password = '',
    this.coachUserName = '',
  });

  SignUpState copyWith({
    bool? isCoach,
    String? firstName,
    String? secondName,
    String? username,
    String? email,
    String? password,
    String? coachUserName,
  }) {
    return SignUpState(
      isCoach: isCoach ?? this.isCoach,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      coachUserName: coachUserName ?? this.coachUserName,
    );
  }
}