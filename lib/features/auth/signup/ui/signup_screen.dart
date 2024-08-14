import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:followupapprefactored/features/auth/signup/data/repository/signup_repo_impl.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/text_strings.dart';
import '../../../../core/utils/validators/validation.dart';
 import '../logic/cubit/sign_up_cubit.dart';
import '../logic/cubit/sign_up_state.dart';
import 'widgets/sign_up_header.dart';
 
 

 class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: dark ? Colors.white : Colors.black,
        ),
      ),
      body: BlocProvider(
        create: (context) => SignUpCubit(SignupRepoImp(ApiService(Dio()))),
        child: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            final signUpCubit = context.read<SignUpCubit>();
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  children: [
                    SignUpHeader(dark: dark),
                    SignUpForm(dark: dark, signUpCubit: signUpCubit),
                    SizedBox(height: 16.h),
                    Center(
                      child: RegisterButton(signUpCubit: signUpCubit),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// GlobalKey for Form

class ClientFormField extends StatelessWidget {
  const ClientFormField({
    super.key,
    required this.dark,
    required this.signUpCubit,
  });

  final bool dark;
  final SignUpCubit signUpCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: dark ? const Color(0xff1f1f1F) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: TextFormField(
              onChanged: signUpCubit.setCoachUserName,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Coach username is required" ;
                }
                return null;
              },
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1f1f1F)),
                ),
                labelText: "Coach Username",
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                fillColor: CColors.secondary,
                filled: dark ? true : false,
                hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
               const   Column(
                    children: [
                       Text("Coach or client"),
                       Text("You're client"),
                    ],
                  ),
                  InkWell(
                    enableFeedback: false,
                    splashColor: Colors.transparent,
                    onTap: signUpCubit.toggleCoach,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: !signUpCubit.state.isCoach
                            ? const Color(0xff797979)
                            : CColors.primary,
                      ),
                      width: 25,
                      height: 25,
                      child: const Center(
                        child: Icon(Icons.check, color: CColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CoachFormField extends StatelessWidget {
  const CoachFormField({
    super.key,
    required this.dark,
    required this.signUpCubit,
  });

  final bool dark;
  final SignUpCubit signUpCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: dark ? const Color(0xff1f1f1F) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: 337.1,
        height: 65,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("You're coach"),
              InkWell(
                enableFeedback: false,
                splashColor: Colors.transparent,
                onTap: signUpCubit.toggleCoach,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: signUpCubit.state.isCoach
                        ? Colors.blueAccent
                        : const Color(0xff797979),
                  ),
                  width: 25,
                  height: 25,
                  child: const Center(
                    child: Icon(Icons.check, color: Color(0xfff6f6f6)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.signUpCubit,
    required this.dark,
  });

  final SignUpCubit signUpCubit;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: CValidator.validateEmail,
      onChanged: signUpCubit.setEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: CTexts.email,
        fillColor: CColors.secondary,
        filled: dark ? true : false,
        hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      ),
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
    );
  }
}

class NamesTextFormFields extends StatelessWidget {
  const NamesTextFormFields({
    super.key,
    required this.signUpCubit,
    required this.dark,
  });

  final SignUpCubit signUpCubit;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            validator: CValidator.validateFirstName,
            onChanged: signUpCubit.setFirstName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "First Name",
              fillColor: CColors.secondary,
              filled: dark ? true : false,
              hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            validator: CValidator.validateSecondName,
            onChanged: signUpCubit.setSecondName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Second Name",
              fillColor: CColors.secondary,
              filled: dark ? true : false,
              hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.signUpCubit,
    required this.dark,
  });

  final SignUpCubit signUpCubit;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: CValidator.validatePassword,
      onChanged: signUpCubit.setPassword,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: CTexts.password,
        fillColor: CColors.secondary,
        filled: dark ? true : false,
        hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      ),
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
    );
  }
}

class UsernameTextFormField extends StatelessWidget {
  const UsernameTextFormField({
    super.key,
    required this.signUpCubit,
    required this.dark,
  });

  final SignUpCubit signUpCubit;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: CValidator.validateUsername,
      onChanged: signUpCubit.setUsername,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: CTexts.username,
        fillColor: CColors.secondary,
        filled: dark ? true : false,
        hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
      ),
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required this.signUpCubit,
  });

  final SignUpCubit signUpCubit;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: const Color(0xff1f1f1F),
      minWidth: 155,
      height: 45.h,
      splashColor: Colors.blueAccent,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onPressed: () async {
        await signUpCubit.signUp(context);
      
      },
      child: Text(
        CTexts.register,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.dark,
    required this.signUpCubit,
  });

  final bool dark;
  final SignUpCubit signUpCubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpCubit.signupFormKey,
      child: Column(
        children: [
          const SizedBox(height: 16),
          NamesTextFormFields(signUpCubit: signUpCubit, dark: dark),
          SizedBox(height: 8.h),
          UsernameTextFormField(signUpCubit: signUpCubit, dark: dark),
          SizedBox(height: 8.h),
          EmailTextFormField(signUpCubit: signUpCubit, dark: dark),
          SizedBox(height: 8.h),
          PasswordTextFormField(signUpCubit: signUpCubit, dark: dark),
          SizedBox(height: 8.h),
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return state.isCoach
                  ? CoachFormField(dark: dark, signUpCubit: signUpCubit)
                  : ClientFormField(dark: dark, signUpCubit: signUpCubit);
            },
          ),
        ],
      ),
    );
  }
}
