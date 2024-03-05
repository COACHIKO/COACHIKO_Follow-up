import 'package:flutter/material.dart';
 import 'package:followupapprefactored/view/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import '../../../controller/api_controller.dart';
import '../../../controller/routines_page_controller.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../../data/model/routine_model.dart';
import '../../../main.dart';
import '../auth/fork_usering_page.dart';

class WorkoutPlanPage extends StatelessWidget {

    WorkoutPlanPage({super.key});

  final controller = Get.put(ApiController());
     // myServices.sharedPreferences.clear();
    // Get.offAll(const ForkUseringPage());
  @override
  Widget build(BuildContext context) {

    var dark = THelperFunctions.isDarkMode(context);
    return GetBuilder<RoutinesPageController>(
      init: RoutinesPageController(),
      builder: (controller) => Scaffold(
         appBar: const CustomAppBar(showBackArrow: false, title: "Workout"),

        body: controller.routines.isEmpty ?
        const Center(child: CircularProgressIndicator(),):
              ListView.builder(
          shrinkWrap: true,
          itemCount: controller.routines.length,
          itemBuilder: (context, index) {
            Routine routine = controller.routines[index];
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 160,
                    width: double.maxFinite,
                    child: Card(
                      color: dark? const Color(0xFF1C1C1E):Colors.white,
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
                                Text(routine.name,style: Theme.of(context).textTheme.titleMedium,),
                                IconButton(
                                  onPressed: () {
                                    myServices.sharedPreferences.clear();
                                    Get.offAll(const ForkUseringPage());

                                  },
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color:CColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              routine.exercises
                                  .map((exercise) => exercise.name)
                                  .join(', '),
                              style: const TextStyle(color: Color(0xFF989799)), maxLines: 1,),
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

                                  controller.startRoutine(routine);
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
      ),
    );
  }
}

//
// class RoutinesPageController extends GetxController {
//   List<Routine> routine = []; //
//
//   void startRoutine(Routine routine) {
//     Get.to(
//       ExerciseLoggingPage(
//         routineName: routine.name,
//         exercises: routine.exercises.map((exercise) => exercise.name).toList(),
//         setsPerExercise: routine.exercises.map((exercise) => exercise.sets).toList(),
//         lastWeights: routine.exercises.map((exercise) => exercise.lastWeight).toList(),
//         rest: routine.exercises.map((exercise) => exercise.rest).toList(),
//       ),
//       transition: Transition.fadeIn,
//       duration: const Duration(milliseconds: 500),
//     );
//   }
//
// }
