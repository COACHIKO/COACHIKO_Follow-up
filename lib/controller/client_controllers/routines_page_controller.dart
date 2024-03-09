import 'package:get/get.dart';
import '../../data/model/exercise_model.dart';
import '../../data/model/routine_model.dart';
import '../../view/screens/client_area/routine_log_page.dart';
import '../../view/screens/coach_area/routine_edit_page.dart';

class RoutinesPageController extends GetxController {
  static RoutinesPageController get instance => Get.find();

  var routineName = ''.obs;
  late Future<WorkoutData> routines;

  late Future<WorkoutData> clientRoutines ;

//   Future<void> loadData() async {
// await  controller.fetchRoutineData();
// update();
//   }
//
//
//

  // void startRoutine(Routine routine) {
  //   Get.to(
  //     ExerciseLoggingPage(
  //       routineName: routine.routineName,
  //       exercises:
  //           routine.exercises.map((exercise) => exercise.exerciseName).toList(),
  //       exercisesImages: routine.exercises
  //           .map((exercise) => exercise.exerciseImage)
  //           .toList(),
  //       setsPerExercise:
  //           routine.exercises.map((exercise) => exercise.sets).toList(),
  //       //  excersiseID: routine.exercises..map((exercise) => exercise.exerciseID).toList(),
  //       //   lastWeights: routine.exercises.map((exercise) => exercise.lastWeight).toList(),
  //       rest: routine.exercises.map((exercise) => exercise.rest).toList(),
  //     ),
  //     transition: Transition.fadeIn,
  //     duration: const Duration(milliseconds: 500),
  //   );
  // }

  void Edit(routineID) {
    Get.to(
      EditRoutinePage(
        routineID: routineID,
      ),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 500),
    );
  }
// Get.to(
//   ExerciseLoggingPage(
//     routine: routine,
//   ),
//   transition: Transition.fadeIn,
//   duration: const Duration(milliseconds: 500),
// );
}
