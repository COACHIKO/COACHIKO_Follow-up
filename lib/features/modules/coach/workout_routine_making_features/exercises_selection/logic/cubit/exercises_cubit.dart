import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/exercises_selection/data/models/exercisesDataBase.dart';
import '../../data/repository/exercises_repo_impl.dart';
import 'exercises_state.dart';

class SelectingExercisesCubit extends Cubit<ExercisesState> {
  final SelectingExercisesRepoImpl exercisesRepoimpl;

  List<Exercises> _allExercises = [];
  final TextEditingController searchController = TextEditingController();
  final List<String> lastSelectedExercises;

  SelectingExercisesCubit(
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
      String query = searchController.text.toLowerCase();
      List<Exercises> filteredFoods = _allExercises.where((exercise) {
        return exercise.exerciseName.toLowerCase().contains(query) ||
            exercise.targetMuscles.toLowerCase().contains(query) ||
            exercise.usedEquipment.toLowerCase().contains(query);
      }).toList();
      emit(LoadedSuccessfullyFoodsState(filteredFoods));
    }
  }

  void toggleFoodSelection(Exercises exercise) {
    final index = _allExercises.indexOf(exercise);
    if (index != -1) {
      _allExercises[index].isSelected = !_allExercises[index].isSelected;
      searchFoods();
    }
  }
}
