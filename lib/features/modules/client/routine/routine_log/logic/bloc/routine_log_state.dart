part of 'routine_log_bloc.dart';

// Define cubit states
abstract class RoutineWeightLogState {}

class RoutineWeightLogInitial extends RoutineWeightLogState {}

class RoutineWeightLogLoaded extends RoutineWeightLogState {
  final List<List<bool>> isFinishedLists;
  final int restTimeLeft;
  final int focused;

  RoutineWeightLogLoaded({
    required this.isFinishedLists,
    required this.restTimeLeft,
    required this.focused,
  });
}
