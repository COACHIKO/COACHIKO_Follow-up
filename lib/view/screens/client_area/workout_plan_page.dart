import 'package:flutter/material.dart';
import 'package:followupapprefactored/view/screens/client_area/routine_log_page.dart';
import 'package:followupapprefactored/view/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import '../../../controller/client_controllers/routines_page_controller.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../../data/model/routine_model.dart';
import '../../../main.dart';
import '../auth_presentation/fork_usering_page.dart';

class WorkoutPlanPage extends StatelessWidget {
  const WorkoutPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);
    final RoutinesPageController routinePageController =
        Get.put(RoutinesPageController());

    return FutureBuilder<WorkoutData>(
      future: routinePageController.routines,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            appBar: CustomAppBar(showBackArrow: false, title: "Workout"),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            appBar: CustomAppBar(showBackArrow: false, title: "Workout"),
            body: Center(child: Text("There's No Routines For You Yet")),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            appBar: const CustomAppBar(showBackArrow: false, title: "Workout"),
            body: ListView.builder(
              itemCount: snapshot.data!.routines.length,
              itemBuilder: (context, index) {
                Routine routine = snapshot.data!.routines[index];
                return SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 160,
                        width: double.maxFinite,
                        child: Card(
                          color: dark ? const Color(0xFF1C1C1E) : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      routine.routineName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        myServices.sharedPreferences.clear();
                                        Get.offAll(const ForkUseringPage());
                                      },
                                      icon: const Icon(
                                        Icons.more_horiz,
                                        color: CColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  routine.exercises
                                      .map((exercise) => exercise.exerciseName)
                                      .join(', '),
                                  style:
                                      const TextStyle(color: Color(0xFF989799)),
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: MaterialButton(
                                    shape: const OutlineInputBorder(
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(5),
                                        right: Radius.circular(5),
                                      ),
                                    ),
                                    onPressed: () async {
                                      print(routine.routineName);
                                      Exercise exercise = routine.exercises[0];
                                      print(exercise.sets);


                                      Get.to(
                                        ExerciseLoggingPage(
                                          routine: routine,
                                        ),
                                        transition: Transition.fadeIn,
                                        duration: const Duration(milliseconds: 500),
                                      );




                                      //  routinePageController
                                      //     .startRoutine(routine);
                                    },
                                    color: CColors.primary,
                                    child: const Text(
                                      'Start Routine',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return const Scaffold(
            appBar: CustomAppBar(showBackArrow: false, title: "Workout"),
            body: Center(child: Text('No data available.')),
          );
        }
      },
    );
  }
}
