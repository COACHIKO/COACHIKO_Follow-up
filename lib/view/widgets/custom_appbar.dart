import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/constants/colors.dart';

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
    return AppBar(
      leading: showBackArrow
          ? IconButton(
        onPressed: () => Get.back(), // Assuming you're using GetX for navigation
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white, // تغيير لون الأيقونة هنا إلى الأبيض
        ),
      )
          : (leadingIcon != null
          ? IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          leadingIcon,
          color: Colors.white, // تغيير لون الأيقونة هنا إلى الأبيض
        ),
      )
          : null),
      backgroundColor: CColors.primary,
      shape: CustomShapeBorder(), // Use your custom shape border here
      title: Text(
          title,style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const double curveHeight = 50;
    final double x = rect.width;
    final double y = rect.height;

    final path = Path()
      ..lineTo(0, y - curveHeight)
      ..quadraticBezierTo(0, y, curveHeight, y)
      ..lineTo(x - curveHeight, y)
      ..quadraticBezierTo(x, y, x, y - curveHeight)
      ..lineTo(x, 0)
      ..lineTo(0, 0);

    // Add circles
    const double circle1Radius = 20;
    final double circle1X = x - 250;
    const double circle1Y = curveHeight - 150;

    const double circle2Radius = 20;
    final double circle2X = x - 250;
    const double circle2Y = curveHeight - 100;

    path.addOval(Rect.fromCircle(center: Offset(circle1X, circle1Y), radius: circle1Radius));
    path.addOval(Rect.fromCircle(center: Offset(circle2X, circle2Y), radius: circle2Radius));

    return path;
  }
}
