import '../../data/models/clients_response.dart';

abstract class ClientState {}

class ClientsInitial extends ClientState {}

class ClientsLoading extends ClientState {}

class ClientsLoadedSuccessfully extends ClientState {
  final List<ClientData> clients;
  ClientsLoadedSuccessfully(this.clients);
}

class ClientsNoData extends ClientState {}

class ClientsError extends ClientState {
  final String error;
  ClientsError(this.error);
}
