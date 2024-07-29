import '../../../../../../core/networking/api_service.dart';
import '../../../../../../core/services/shared_pref/shared_pref.dart';
import '../models/clients_data_request_body.dart';
import '../models/clients_response.dart';
import 'client_repo.dart';

class ClientsDataRepoImp implements ClientsDataRepo {
  final ApiService _apiService;
  ClientsDataRepoImp(this._apiService);

  @override
  Future<List<ClientData>> getAllClients(
      ClientsDataRequestBody clientDataRequestBody) async {
    try {
      var response = await _apiService.getClients(
          clientsDataRequestBody: ClientsDataRequestBody(
              user: SharedPref().getInt("user").toString()));

      var parsedData = ClientsDataResponse.fromJson(response);
      return parsedData.clients!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
