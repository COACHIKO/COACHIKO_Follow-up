import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/features/auth/signup/ui/widgets/sign_up_form.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../logic/signup_controller.dart';
import 'widgets/register_button.dart';
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
      body: GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (signUpController) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              children: [
                /// Header
                SignUpHeader(dark: dark),

                /// Form
                SignUpForm(
                  dark: dark,
                  signUpController: signUpController,
                ),
                SizedBox(height: 16.h),

                /// Button
                Center(
                  child: RegisterButton(
                    signUpController: signUpController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
