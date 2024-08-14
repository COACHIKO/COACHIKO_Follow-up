import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../view/screens/fork_usering_page.dart';
import '../../data/models/signup_request_model.dart';
import '../../data/repository/signup_repo_impl.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignupRepoImp signupRepoImp;

  SignUpCubit(this.signupRepoImp) : super(SignUpState());

  void toggleCoach() {
    emit(state.copyWith(isCoach: !state.isCoach));
  }

  void setFirstName(String value) {
    emit(state.copyWith(firstName: value));
  }

  void setSecondName(String value) {
    emit(state.copyWith(secondName: value));
  }

  void setUsername(String value) {
    emit(state.copyWith(username: value));
  }

  void setEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void setPassword(String value) {
    emit(state.copyWith(password: value));
  }

  void setCoachUserName(String value) {
    emit(state.copyWith(coachUserName: value));
  }
final GlobalKey<FormState>  signupFormKey = GlobalKey<FormState>();

  Future<void> signUp( context) async {
 
    if (signupFormKey.currentState!.validate()) {
      var response = await signupRepoImp.register(SignupRequestBody(
        username: state.username,
        password: state.password,
        email: state.email,
        firstName: state.firstName,
        secondName: state.secondName,
        isCoach: state.isCoach ? 1 : 0,
        coachUserName: state.coachUserName,
      ));
      if (response.status == "success") {
        Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: response.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: response.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
        );
      }
        Navigator.pushReplacement(  context,
            MaterialPageRoute(builder: (context) => const ForkUseringPage()));
    }
  }
}