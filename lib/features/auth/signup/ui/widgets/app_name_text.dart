import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/text_strings.dart';

class AppName extends StatelessWidget {
  const AppName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      CTexts.appName,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
