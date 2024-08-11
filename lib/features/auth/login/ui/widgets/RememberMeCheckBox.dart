import 'package:flutter/material.dart';

import '../../logic/cubit/login_cubit.dart';

class RememberMeCheckBox extends StatefulWidget {
  const RememberMeCheckBox({
    super.key,
    required this.cubit,
  });

  final LoginCubit cubit;

  @override
  State<RememberMeCheckBox> createState() => _RememberMeCheckBoxState();
}

class _RememberMeCheckBoxState extends State<RememberMeCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.cubit.rememberMe,
      onChanged: (value) {
        setState(() {
          widget.cubit.rememberMe = value!;
        });
      },
    );
  }
}
