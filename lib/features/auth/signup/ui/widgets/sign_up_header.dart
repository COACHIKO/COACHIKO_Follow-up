import 'package:flutter/material.dart';
import 'package:followupapprefactored/features/auth/signup/ui/widgets/signup_welcome_text.dart';

import '../../../../../core/utils/constants/sizes.dart';
import 'app_logo_image.dart';
import 'app_name_text.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppLogo(dark: dark),
      const AppName(),
      const SizedBox(height: TSizes.sm),
      const SignUpWelcome(),

    ],);
  }
}
