import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/text_strings.dart';
import '../../../../../core/utils/validators/validation.dart';
import '../../logic/cubit/login_cubit.dart';

class UserNameFormField extends StatelessWidget {
  const UserNameFormField({
    super.key,
    required this.cubit,
  });

  final LoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: CTexts.usernameOrEmail),
      validator: CValidator.validateUsernameOrEmail,
      onChanged: (value) {
        cubit.username = value;
      },
      keyboardType: TextInputType.text,
    );
  }
}
