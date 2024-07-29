import 'package:flutter/material.dart';
import '../../../core/utils/constants/colors.dart';
import '../../core/utils/helpers/helper_functions.dart';
import '../day_night_switch.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackArrow;
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? leadingOnPressed;

  const CustomAppBar({
    super.key,
    required this.showBackArrow,
    this.leadingIcon,
    this.leadingOnPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);

    return AppBar(
      centerTitle: true,
      leading: showBackArrow
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            )
          : (leadingIcon != null
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    leadingIcon,
                    color: Colors.white,
                  ),
                )
              : null),
      backgroundColor: CColors.darkGrey.withOpacity(0.1),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: dark ? Colors.white : Colors.black)),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: ThemeButton(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
