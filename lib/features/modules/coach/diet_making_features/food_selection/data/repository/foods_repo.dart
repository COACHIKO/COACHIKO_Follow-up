import '../models/food_model.dart';

abstract class FoodsRepo {
  Future<List<FoodDataModel>> getFoods();
}
