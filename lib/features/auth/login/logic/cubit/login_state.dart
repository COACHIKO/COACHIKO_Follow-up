import 'package:flutter/material.dart';

class LoginState {
  final GlobalKey<FormState> formKey;
  final String firebaseToken;

  LoginState({
    GlobalKey<FormState>? formKey,
    this.firebaseToken = '',
  }) : formKey = formKey ?? GlobalKey<FormState>();

  LoginState copyWith({
    bool? obscurePassword,
    GlobalKey<FormState>? formKey,
    String? firebaseToken,
  }) {
    return LoginState(
      formKey: formKey ?? this.formKey,
      firebaseToken: firebaseToken ?? this.firebaseToken,
    );
  }
}
