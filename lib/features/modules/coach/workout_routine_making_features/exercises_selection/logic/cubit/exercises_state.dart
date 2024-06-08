import '../../data/models/exercisesDataBase.dart';

abstract class ExercisesState {}

class FoodStateInitial extends ExercisesState {}

class FoodsStateLoading extends ExercisesState {
  FoodsStateLoading();
}

class LoadedSuccessfullyFoodsState extends ExercisesState {
  final List<Exercises> exercises;

  LoadedSuccessfullyFoodsState(this.exercises);
}

class IntialSelectedExercises extends ExercisesState {
  final void Function() intialSelectedExercises;

  IntialSelectedExercises({required this.intialSelectedExercises});
}

class FoodsStateError extends ExercisesState {
  final String error;

  FoodsStateError(this.error);
}
