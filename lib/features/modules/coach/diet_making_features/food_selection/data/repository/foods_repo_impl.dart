import '../../../../../../../../../../../core/networking/api_service.dart';
import '../models/food_model.dart';
import 'foods_repo.dart';

class FoodsRepoImpl implements FoodsRepo {
  final ApiService _apiService;
  FoodsRepoImpl(this._apiService);

  @override
  Future<List<FoodDataModel>> getFoods() async {
    try {
      var response = await _apiService.getFoodsData();
      var foodList =
          response.map((item) => FoodDataModel.fromJson(item)).toList();

      return foodList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
