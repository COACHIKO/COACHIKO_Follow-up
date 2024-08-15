abstract class ExercisesAssignmentStates {}

class FoodQuantitiesInitialState extends ExercisesAssignmentStates {}

class ListShrinkedUpdateState extends ExercisesAssignmentStates {
  ListShrinkedUpdateState();
}

class FoodsStateErrors extends ExercisesAssignmentStates {
  final String error;

  FoodsStateErrors(this.error);
}
