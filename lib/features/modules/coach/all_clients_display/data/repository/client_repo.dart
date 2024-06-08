import '../models/clients_data_request_body.dart';
import '../models/clients_response.dart';

abstract class ClientsDataRepo {
  Future<List<ClientData>> getAllClients(
      ClientsDataRequestBody clientsDataRequestBody);
}
