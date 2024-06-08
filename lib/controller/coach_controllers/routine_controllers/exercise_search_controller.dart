import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/models/routine_response.dart';
import 'package:get/get.dart';

class ExerciseSearchPageController extends GetxController {
  static ExerciseSearchPageController get instance => Get.find();

  RxList<Exercise> exercises = <Exercise>[].obs;
  RxList<Exercise> selectedExercises = <Exercise>[].obs;
  RxString searchController = ''.obs;
  void toggleSelection(int index) {
    exercises[index].isSelected = !exercises[index].isSelected;
    update();
  }

  void filterExercises() {
    if (searchController.isEmpty) {
      // If query is empty, show all exercises
      selectedExercises.assignAll(exercises);
    } else {
      // Filter exercises based on the query
      selectedExercises.assignAll(exercises.where((exercise) =>
          exercise.exerciseName
              .toString()
              .contains(searchController.toLowerCase()) ||
          exercise.targetMuscles
              .toLowerCase()
              .contains(searchController.toLowerCase()) ||
          exercise.usedEquipment
              .toLowerCase()
              .contains(searchController.toLowerCase())));
    }
    update();
  }
}
