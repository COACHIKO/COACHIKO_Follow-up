import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/utils/theme/cubit/theme_cubit.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        bool isDarkMode = themeMode == ThemeMode.dark;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(
              activeTrackColor: Colors.blueAccent,
              activeColor: Colors.green,
              activeThumbImage: const AssetImage('assets/images/moon.png'),
              inactiveThumbImage: const AssetImage('assets/images/sun.png'),
              value: isDarkMode,
              onChanged: (value) {
                context.read<ThemeCubit>().toggleTheme(value);
              },
            ),
          ],
        );
      },
    );
  }
}
