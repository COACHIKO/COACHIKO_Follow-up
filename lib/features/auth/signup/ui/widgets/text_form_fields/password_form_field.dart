import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/utils/constants/text_strings.dart';
import 'package:followupapprefactored/core/utils/validators/validation.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../logic/signup_controller.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.signUpController,
    required this.dark,
  });

  final SignUpController signUpController;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: CValidator.validatePassword,
      onChanged: (value) => signUpController.password.value = value,
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
