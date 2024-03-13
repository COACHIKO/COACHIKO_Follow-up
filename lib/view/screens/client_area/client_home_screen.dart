import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/view/screens/client_area/routine_screens/workout_plan_page.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedindex=0;

  final pages = [  const WorkoutPlanPage(), const WorkoutPlanPage(), const WorkoutPlanPage(), const WorkoutPlanPage(),];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
        body:  pages[selectedindex],
        bottomNavigationBar:  Container(
          padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
          child: GNav(
            rippleColor: Colors.grey.shade800, hoverColor: Colors.grey.shade700, haptic: true,tabBorderRadius: 10,
            tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8)], gap: 8, curve: Curves.bounceIn,
            color: Colors.grey[800], activeColor: Colors.white, iconSize: 24,tabBackgroundColor: Colors.black.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tabs:  [
              GButton(
                icon: Icons.fitness_center_rounded,
                text: '47'.tr,
              ),
              GButton(
                icon: Icons.set_meal,
                text: '48'.tr,
              ),
              GButton(
                icon: Icons.stacked_line_chart,
                text: '49'.tr,
              ),
              GButton(
                icon: Icons.account_box_outlined,
                text: '50'.tr,
              )
            ],
            selectedIndex: selectedindex,
            onTabChange: (value) {
              setState(() {
                selectedindex=value;

              });

            },

          ),
        )


    );}}




