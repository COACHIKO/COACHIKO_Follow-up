abstract class FoodQuantitiesStates {}

class FoodQuantitiesInitialState extends FoodQuantitiesStates {}

class FoodQuantitiesUpdateState extends FoodQuantitiesStates {
  FoodQuantitiesUpdateState(String text, int index);
}

class FoodsStateError extends FoodQuantitiesStates {
  final String error;

  FoodsStateError(this.error);
}
