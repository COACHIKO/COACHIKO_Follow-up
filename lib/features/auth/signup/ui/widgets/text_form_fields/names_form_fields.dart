import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/utils/constants/text_strings.dart';
import 'package:followupapprefactored/core/utils/validators/validation.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../logic/signup_controller.dart';

class NamesTextFormFields extends StatelessWidget {
  const NamesTextFormFields({
    super.key,
    required this.signUpController,
    required this.dark,
  });

  final SignUpController signUpController;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// First Name TextFormField
        Expanded(
          child: TextFormField(
            validator: CValidator.validateFirstName,
            onChanged: (value) => signUpController.firstName.value = value,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: CTexts.firstName,
              fillColor: CColors.secondary,
              filled: dark ? true : false,
              hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
        const SizedBox(width: 16),

        /// Second Name TextFormField
        Expanded(
          child: TextFormField(
            validator: CValidator.validateSecondName,
            onChanged: (value) => signUpController.secondName.value = value,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: CTexts.secondName,
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
