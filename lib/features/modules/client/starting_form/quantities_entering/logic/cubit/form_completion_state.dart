abstract class FormComplectionStates {}

class FoodQuantitiesInitialState extends FormComplectionStates {}

class UpdateState extends FormComplectionStates {
  UpdateState();
}

class FoodsStateError extends FormComplectionStates {
  final String error;

  FoodsStateError(this.error);
}
