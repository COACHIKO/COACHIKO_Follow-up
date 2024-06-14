import '../../../../../../../data/model/diet_models/food_model.dart';

abstract class FoodsState {}

class FoodStateInitial extends FoodsState {
  final List<FoodDataModel> selectedFoods;

  FoodStateInitial(this.selectedFoods);
}

class FoodsStateLoading extends FoodsState {}

class Update extends FoodsState {}

class LoadedSuccessfullyFoodsState extends FoodsState {
  final List<FoodDataModel> foods;

  LoadedSuccessfullyFoodsState(this.foods);
}

class FoodsStateError extends FoodsState {
  final String error;

  FoodsStateError(this.error);
}
