import '../../../../../../../../../../../core/networking/api_service.dart';
import '../models/quantity_insertion_request_body.dart';
import '../models/quantity_insertion_response.dart';
import 'food_quantities_repo.dart';

class FoodQuantitiesRepoImp implements FoodQuantitiesRepo {
  final ApiService _apiService;
  FoodQuantitiesRepoImp(this._apiService);

  @override
  Future<QuantityInsertionResponse> enterQuantites(
      QuantityInsertionRequestBody quantityInsertionRequestBody) async {
    try {
      var response = await _apiService.foodQuantityEnter(
          quantityInsertionRequestBody: quantityInsertionRequestBody);
      var parsedData = QuantityInsertionResponse.fromJson(response);
      return parsedData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
