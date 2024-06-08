part of 'routine_log_bloc.dart';

// Define cubit events
abstract class RoutineWeightLogEvent {}

class StartRestTimerEvent extends RoutineWeightLogEvent {
  final int restDuration;

  StartRestTimerEvent(this.restDuration);
}

class UpdateExerciseLogEvent extends RoutineWeightLogEvent {
  final int exerciseIndex;
  final int setIndex;

  UpdateExerciseLogEvent(this.exerciseIndex, this.setIndex);
}
