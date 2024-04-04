import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/features/auth/signup/ui/widgets/text_form_fields/username_form_field.dart';
import 'package:get/get.dart';
import '../../logic/signup_controller.dart';
import 'text_form_fields/client_form_field.dart';
import 'text_form_fields/coach_form_field.dart';
import 'text_form_fields/email_form_field.dart';
import 'text_form_fields/names_form_fields.dart';
import 'text_form_fields/password_form_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key,required this.dark,required this.signUpController,});
  final bool dark;
  final SignUpController signUpController;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpController.signupkey,
      child: Column(
        children: [
          const SizedBox(height: 16),
          NamesTextFormFields(signUpController: signUpController, dark: dark),
          SizedBox(height: 8.h),
          UsernameTextFormField(signUpController: signUpController, dark: dark),
          SizedBox(height: 8.h),
          EmailTextFormField(signUpController: signUpController, dark: dark),
          SizedBox(height: 8.h),
          PasswordTextFormField(signUpController: signUpController, dark: dark),
          SizedBox(height: 8.h),
          GetX<SignUpController>(
                builder: (controller) => controller.isCoach.isFalse
                ? ClientFormField(dark: dark, signUpController: signUpController,)
                : CoachFormField(dark: dark,signUpController: signUpController,),
          ),
        ],
      ),
    );
  }
}
