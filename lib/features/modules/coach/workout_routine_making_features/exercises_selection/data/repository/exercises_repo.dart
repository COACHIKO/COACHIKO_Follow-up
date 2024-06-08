import '../models/exercisesDataBase.dart';

abstract class ExercisesRepo {
  Future<List<Exercises>> getExercises();
}
