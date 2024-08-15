import '../../../features/modules/client/routine/routine_get/data/models/routine_response.dart';
import '../../../features/modules/coach/all_clients_display/data/models/clients_response.dart';
import '../../../features/modules/coach/diet_making_features/food_selection/data/models/food_model.dart';
import '../../../features/modules/coach/workout_routine_making_features/exercises_selection/data/models/exercisesDataBase.dart';

class TrackHistoryParams {
  final int userId;
  final String name;

  TrackHistoryParams({
    required this.userId,
    required this.name,
  });
}

class SelectedFoodsParams {
  final ClientData clientData;
  final List<FoodDataModel> selectedFoods;

  SelectedFoodsParams({
    required this.clientData,
    required this.selectedFoods,
  });
}

class ExerciseAssignmentParams {
  final ClientData clientData;
  final Routine routine;
  final List<Exercises> oldExercises;

  ExerciseAssignmentParams({
    required this.clientData,
    required this.routine,
    required this.oldExercises,
  });
}

class ExerciseSelectionParams {
  final ClientData clientData;
  final Routine routine;
  final List<String> oldExercises;

  ExerciseSelectionParams({
    required this.clientData,
    required this.routine,
    required this.oldExercises,
  });
}
