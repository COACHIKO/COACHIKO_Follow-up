import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../logic/cubit/login_cubit.dart';

class VisibleIconButton extends StatefulWidget {
  const VisibleIconButton({
    super.key,
    required this.cubit,
  });

  final LoginCubit cubit;

  @override
  State<VisibleIconButton> createState() => _VisibleIconButtonState();
}

class _VisibleIconButtonState extends State<VisibleIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
          widget.cubit.passwordVisibility ? Iconsax.eye_slash : Iconsax.eye),
      onPressed: () {
        setState(() {
          widget.cubit.passwordVisibility = !widget.cubit.passwordVisibility;
        });
      },
    );
  }
}
