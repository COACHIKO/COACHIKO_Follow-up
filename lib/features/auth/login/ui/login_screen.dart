import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import '../data/repository/login_repo_impl.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import '../../../../../../core/utils/helpers/helper_functions.dart';
import '../logic/cubit/login_cubit.dart';
import '../logic/cubit/login_state.dart';
import 'widgets/LoginForm.dart';
import 'widgets/LoginHeader.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepoImp(ApiService(Dio()))),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: THelperFunctions.isDarkMode(context)
                ? Colors.white
                : Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                var cubit = context.read<LoginCubit>();
                var dark = THelperFunctions.isDarkMode(context);
                return Form(
                  key: state.formKey,
                  child: Column(
                    children: [
                      LoginHeader(dark: dark),
                      // Form
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: TSizes.spaceBtwSections),
                        child: LoginForm(cubit: cubit),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
