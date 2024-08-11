import 'package:flutter/material.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../logic/cubit/login_cubit.dart';

class SignInMaterialButton extends StatelessWidget {
  const SignInMaterialButton({
    super.key,
    required this.cubit,
  });

  final LoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          cubit.signIn(context);
        },
        child: Text(AppLocalizations.of(context).translate('signin')),
      ),
    );
  }
}
