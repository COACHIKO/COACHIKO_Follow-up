import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/clients_data_request_body.dart';
import '../../data/repository/clients_repo_impl.dart';
import 'clients_state.dart';

class ClientsCubit extends Cubit<ClientState> {
  final ClientsDataRepoImp clientsRepoImp;
  ClientsCubit({required this.clientsRepoImp}) : super(ClientsInitial());

  Future<void> getAllClientsData() async {
    try {
      emit(ClientsLoading());
      var clients = await clientsRepoImp
          .getAllClients(ClientsDataRequestBody(user: 1.toString()));
      if (clients.isEmpty) {
        emit(ClientsNoData());
      } else {
        emit(ClientsLoadedSuccessfully(clients));
      }
    } catch (e) {
      emit(ClientsError(e.toString()));
    }
  }

  Future<T> getFutureWithTimeout<T>(Future<T> future, Duration timeout) {
    final completer = Completer<T>();
    future.then((value) {
      completer.complete(value);
    }).catchError((error) {
      completer.completeError(error);
    });
    Future.delayed(timeout, () {
      if (!completer.isCompleted) {
        completer.completeError('Timeout');
      }
    });
    return completer.future;
  }

  sendMessage(title, message, token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAArxpC8tI:APA91bEw_Xt-nUYuI2bOVaNNUliTbg6aaRZi2y6S3X8-dcSyNh4ZiwK8LNl64oaLKZJe-UL2x-86xyWQ16siEDNVeMY_Z-KzSRBZ2hri2lyKVdtX3V8XAmy_QR8jzxxiKseDE64aPXBK'
    };
    var request =
        http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "to": token,
      "notification": {
        "title": title,
        "body": message,
        "mutable_content": true,
        "sound": "Tri-tone"
      }
    });
    request.headers.addAll(headers);

    request.send();
  }
}
