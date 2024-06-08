import '../models/diet_request_body.dart';
import '../models/diet_response.dart';

abstract class DietRepo {
  Future<List<DietItem>> getDiet(DietRequestBody dietRequestBody);
}



// import 'dart:convert';

// import '../../../../../../../core/networking/api_service.dart';
// import '../models/diet_request_body.dart';
// import '../models/diet_response.dart';
// import 'routine_repo.dart';
// import 'package:http/http.dart' as http;

// class DietRepoImp implements DietRepo {
//   final ApiService _apiService;
//   DietRepoImp(this._apiService);

//   @override
  // Future<List<DietItem>> getDiet(DietRequestBody dietRequestBody) async {
  //   try {
  //     var response = await _apiService.getDietData(dietRequestBody);
  //     return response.diet;
  //   } catch (e) {
  //     print(e);
  //     throw Exception(e.toString());
  //   }
  // }

//   Future<List<DietItem>> getDiet(DietRequestBody dietRequestBody) async {
//     var url =
//         Uri.http("192.168.1.6", "/coachiko/clientArea/diet_get_for_client.php");
//     var response = await http.post(url, body: {
//       "client_id": dietRequestBody.clientId,
//     });
//     var responseData = json.decode(response.body);
//     print(responseData.runtimeType);

//     var parsedData = DietResponse.fromJson(responseData);

//     return parsedData.diet;
//   }
// }
