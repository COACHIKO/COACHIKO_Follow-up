import 'package:equatable/equatable.dart';

import '../../data/models/client_log_history_response.dart';

abstract class HistoryLogsState extends Equatable {
  const HistoryLogsState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryLogsState {}

class HistoryLoading extends HistoryLogsState {}

class HistoryLoaded extends HistoryLogsState {
  final ClientLogsResponseBody clientLogs;

  const HistoryLoaded({required this.clientLogs});
}

class HistoryError extends HistoryLogsState {
  final String message;

  const HistoryError({required this.message});

  @override
  List<Object> get props => [message];
}

class HistoryNoData extends HistoryLogsState {}

class UpdateUi extends HistoryLogsState {}
