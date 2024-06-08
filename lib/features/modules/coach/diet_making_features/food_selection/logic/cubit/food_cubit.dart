import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../data/model/diet_models/food_model.dart';
import '../../data/repository/foods_repo_impl.dart';
import 'food_state.dart';

class FoodCubit extends Cubit<FoodsState> {
  final FoodsRepoImpl foodsRepoImpl;
  List<FoodDataModel> _allFoods = [];
  final TextEditingController searchController = TextEditingController();
  FoodCubit({required this.foodsRepoImpl}) : super(FoodStateInitial());

  Future<void> getFoods() async {
    try {
      emit(FoodsStateLoading());
      var foods = await foodsRepoImpl.getFoods();
      _allFoods = foods;
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
}
