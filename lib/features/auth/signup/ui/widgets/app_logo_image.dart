import 'package:flutter/material.dart';
import 'package:followupapprefactored/core/utils/constants/image_strings.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(
        height: 120,
        image: AssetImage(
            dark ? TImages.lightAppLogo : TImages.darkAppLogo),
      ),
    );
  }
}
