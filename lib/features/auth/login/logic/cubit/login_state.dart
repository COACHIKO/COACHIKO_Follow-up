import 'package:flutter/material.dart';

class LoginState {
  final String username;
  final String password;
  final bool obscurePassword;
  final bool rememberMe;
  final GlobalKey<FormState> formKey;
  final String firebaseToken;

  LoginState({
    this.username = '',
    this.password = '',
    this.obscurePassword = true,
    this.rememberMe = false,
    GlobalKey<FormState>? formKey,
    this.firebaseToken = '',
  }) : formKey = formKey ?? GlobalKey<FormState>();

  LoginState copyWith({
    String? username,
    String? password,
    bool? obscurePassword,
    bool? rememberMe,
    GlobalKey<FormState>? formKey,
    String? firebaseToken,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
      formKey: formKey ?? this.formKey,
      firebaseToken: firebaseToken ?? this.firebaseToken,
    );
  }
}
