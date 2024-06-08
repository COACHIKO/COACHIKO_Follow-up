import '../../data/models/routine_response.dart';

abstract class RoutineState {}

class RoutineInitial extends RoutineState {}

class RoutineLoading extends RoutineState {}

class RoutineLoadedSuccessfully extends RoutineState {
  final List<Routine> routines;

  RoutineLoadedSuccessfully(this.routines);
}

class RoutineNoData extends RoutineState {}

class RoutineError extends RoutineState {
  final String error;

  RoutineError(this.error);
}
