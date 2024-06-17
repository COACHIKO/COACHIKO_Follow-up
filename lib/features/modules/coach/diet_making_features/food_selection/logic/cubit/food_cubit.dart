import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/food_model.dart';
import '../../data/repository/foods_repo_impl.dart';
import 'food_state.dart';

class FoodCubit extends Cubit<FoodsState> {
  final FoodsRepoImpl foodsRepoImpl;
  List<FoodDataModel> selectedfoods;
  List<FoodDataModel> _allFoods = [];
  final TextEditingController searchController = TextEditingController();

  FoodCubit({required this.foodsRepoImpl, required this.selectedfoods})
      : super(FoodStateInitial(selectedfoods)) {
    // Initialize the selected foods
    _initializeSelectedFoods();
  }

  Future<void> getFoods() async {
    try {
      emit(FoodsStateLoading());
      var foods = await foodsRepoImpl.getFoods();
      _allFoods = foods;

      // Update selection status of foods
      _updateSelectionStatus();

      if (foods.isEmpty) {
        emit(LoadedSuccessfullyFoodsState([]));
      } else {
        emit(LoadedSuccessfullyFoodsState(foods));
      }
    } catch (e) {
      emit(FoodsStateError(e.toString()));
    }
  }

  List<FoodDataModel> selectedFoods() {
    final selectedFoods = _allFoods.where((food) => food.isSelected).toList();
    return selectedFoods;
  }

  void searchFoods() {
    if (searchController.text.isEmpty) {
      emit(LoadedSuccessfullyFoodsState(_allFoods));
    } else {
      List<FoodDataModel> filteredFoods = _allFoods
          .where((food) => food.foodName
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
      emit(LoadedSuccessfullyFoodsState(filteredFoods));
    }
  }

  void toggleFoodSelection(FoodDataModel food) {
    final index = _allFoods.indexOf(food);
    if (index != -1) {
      _allFoods[index].isSelected = !_allFoods[index].isSelected;
      searchFoods();
    }
  }

  void _initializeSelectedFoods() {
    // Mark initial selected foods and avoid duplicates
    selectedfoods.map((food) => food.id).toSet();
    selectedfoods = selectedfoods.toSet().toList();
    for (var food in selectedfoods) {
      food.isSelected = true;
    }
  }

  void _updateSelectionStatus() {
    // Ensure _allFoods reflect the selection state
    final selectedFoodIds = selectedfoods.map((food) => food.id).toSet();
    for (var food in _allFoods) {
      if (selectedFoodIds.contains(food.id)) {
        food.isSelected = true;
      }
    }
  }
}
