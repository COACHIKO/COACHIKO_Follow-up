import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/text_strings.dart';

class SignUpWelcome extends StatelessWidget {
  const SignUpWelcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      CTexts.signupSubTitle,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
