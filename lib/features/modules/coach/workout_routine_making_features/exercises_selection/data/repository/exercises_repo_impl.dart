import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/exercises_selection/data/models/exercisesDataBase.dart';
import '../../../../../../../../../../../core/networking/api_service.dart';
import 'exercises_repo.dart';

class SelectingExercisesRepoImpl implements ExercisesRepo {
  final ApiService _apiService;
  SelectingExercisesRepoImpl(this._apiService);

  @override
  Future<List<Exercises>> getExercises() async {
    try {
      var response = await _apiService.getExercisesData();
      var exercisesList =
          response.map((item) => Exercises.fromJson(item)).toList();

      return exercisesList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
