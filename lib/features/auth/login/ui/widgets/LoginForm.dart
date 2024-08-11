import 'package:flutter/material.dart';
import 'package:followupapprefactored/features/auth/login/ui/widgets/RememberMeCheckBox.dart';
import 'package:followupapprefactored/features/auth/login/ui/widgets/VisibleButton.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/sizes.dart';
import '../../../../../core/utils/validators/validation.dart';
import '../../logic/cubit/login_cubit.dart';
import 'SignInMaterialButton.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.cubit,
  });

  final LoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Username Or Email TEXTFORMFIELD
        TextFormField(
          decoration: InputDecoration(
            labelText:
                AppLocalizations.of(context).translate('usernameoremail'),
          ),
          validator: CValidator.validateUsernameOrEmail,
          onChanged: (value) {
            cubit.username = value;
          },
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        // Password TEXTFORMFIELD
        TextFormField(
          onChanged: (value) {
            cubit.password = value;
          },
          validator: CValidator.validatePassword, // Validation for password
          obscureText: cubit.passwordVisibility,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password_outlined),
            suffixIcon: VisibleIconButton(cubit: cubit),
            labelText: AppLocalizations.of(context).translate('password'),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields / 2),
        // Remember me & Forget Password
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Remember me
            Row(
              children: [
                RememberMeCheckBox(cubit: cubit),
                Text(AppLocalizations.of(context).translate('rememberme')),
              ],
            ),

            // Forget Password
            TextButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context).translate('forgotpassword'),
                style: const TextStyle(color: CColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        // Sign In button
        SignInMaterialButton(cubit: cubit),
      ],
    );
  }
}
