import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/text_strings.dart';
import '../../../../../../core/utils/validators/validation.dart';
import '../../../logic/signup_controller.dart';

class UsernameTextFormField extends StatelessWidget {
  const UsernameTextFormField({
    super.key,
    required this.signUpController,
    required this.dark,
  });

  final SignUpController signUpController;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: CValidator.validateUsername,
      onChanged: (value) => signUpController.username.value = value,
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
