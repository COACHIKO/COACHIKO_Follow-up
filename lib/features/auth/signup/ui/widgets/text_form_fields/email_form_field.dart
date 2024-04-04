import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/utils/constants/text_strings.dart';
import 'package:followupapprefactored/core/utils/validators/validation.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../logic/signup_controller.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.signUpController,
    required this.dark,
  });

  final SignUpController signUpController;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: CValidator.validateEmail,
      onChanged: (value) => signUpController.email.value = value,
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
