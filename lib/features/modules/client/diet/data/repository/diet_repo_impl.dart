import 'package:followupapprefactored/main.dart';
import '../../../../../../core/networking/api_service.dart';
import '../models/diet_request_body.dart';
import '../models/diet_response.dart';
import 'routine_repo.dart';

class DietRepoImp implements DietRepo {
  final ApiService _apiService;
  DietRepoImp(this._apiService);

  @override
  Future<DietData> getDiet(DietRequestBody dietRequestBody) async {
    try {
      var response = await _apiService.getDiet(
          dietRequestBody: DietRequestBody(
              clientId:
                  myServices.sharedPreferences.getInt("user").toString()));
      var parsedData = DietResponse.fromJson(response);
      return parsedData.data!;
    } catch (e) {
      throw Exception('Failed to load diet data');
    }
  }
}
