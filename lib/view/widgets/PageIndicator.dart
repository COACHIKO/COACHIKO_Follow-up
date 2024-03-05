import 'package:flutter/material.dart';

Widget buildPageIndicator(int currentPage) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      8, // Change this to the number of pages you have
          (index) => buildDot(index, currentPage),
    ),
  );
}

Widget buildDot(int index, int currentPage) {
  bool isCurrentPage = index == currentPage;
  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    margin: const EdgeInsets.symmetric(horizontal: 5),
    width: isCurrentPage ? 16 : 8,
    height: isCurrentPage ? 16 : 8,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isCurrentPage ? Colors.blue : Colors.grey,
    ),
  );
}




class BackwardOnlyScrollPhysics extends ScrollPhysics {
  const BackwardOnlyScrollPhysics({super.parent});

  @override
  BackwardOnlyScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BackwardOnlyScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position,
      double velocity,
      ) {
    if (velocity < 0.0) {
      // Allow scrolling only when velocity is backward
      return super.createBallisticSimulation(position, velocity);
    }
    return null; // Prevent forward scrolling
  }
}