import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/exercises_selection/data/models/exercisesDataBase.dart';
import '../../data/repository/exercises_repo_impl.dart';
import 'exercises_state.dart';

class ExercisesCubit extends Cubit<ExercisesState> {
  final ExercisesRepoImpl exercisesRepoimpl;

  List<Exercises> _allExercises = [];
  final TextEditingController searchController = TextEditingController();
  final List<String> lastSelectedExercises;

  ExercisesCubit(
      {required this.exercisesRepoimpl, required this.lastSelectedExercises})
      : super(FoodStateInitial());

  Future<void> getFoods() async {
    try {
      emit(FoodsStateLoading());
      var exercises = await exercisesRepoimpl.getExercises();
      _allExercises = exercises;

      for (var exercise in _allExercises) {
        if (lastSelectedExercises.contains(exercise.exerciseID)) {
          exercise.isSelected = true;
        }
      }

      if (exercises.isEmpty) {
        emit(LoadedSuccessfullyFoodsState([]));
      } else {
        emit(LoadedSuccessfullyFoodsState(_allExercises));
      }
    } catch (e) {
      emit(FoodsStateError(e.toString()));
    }
  }

  List<Exercises> selectedFoods() {
    final selectedExercises =
        _allExercises.where((exercise) => exercise.isSelected).toList();

    return selectedExercises;
  }

  void searchFoods() {
    if (searchController.text.isEmpty) {
      emit(LoadedSuccessfullyFoodsState(_allExercises));
    } else {
      List<Exercises> filteredFoods = _allExercises
          .where((food) => food.exerciseName
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
      emit(LoadedSuccessfullyFoodsState(filteredFoods));
    }
  }

  void toggleFoodSelection(Exercises food) {
    final index = _allExercises.indexOf(food);
    if (index != -1) {
      _allExercises[index].isSelected = !_allExercises[index].isSelected;
      searchFoods();
    }
  }
}
