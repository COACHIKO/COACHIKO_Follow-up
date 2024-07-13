import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

import '../../data/models/client_log_history_request_body.dart';
import '../../data/repository/get_log_history_repo_imp.dart';
import 'log_history_state.dart';

class LogHistoryCubit extends Cubit<HistoryLogsState> {
  final GetLogHistoryRepoImp getLogHistoryRepoImp;

  LogHistoryCubit({required this.getLogHistoryRepoImp})
      : super(HistoryInitial());

  Future<void> getLogsHistory(user) async {
    emit(HistoryLoading());
    try {
      final clientLogsResponse = await getLogHistoryRepoImp
          .getLogsHistory(ClientLogsRequestBody(user: user.toString()));
      if (clientLogsResponse.isBlank!) {
        emit(HistoryNoData());
      } else {
        emit(HistoryLoaded(clientLogs: clientLogsResponse));
      }
    } catch (e) {
      emit(HistoryError(message: 'Error fetching diet data $e'));
    }
  }

  void UpdateUi() {
    emit(state);
  }
}
