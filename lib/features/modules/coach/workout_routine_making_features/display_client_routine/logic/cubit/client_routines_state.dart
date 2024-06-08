import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/models/routine_response.dart';

abstract class ClientRoutinesState {}

class RoutineInitial extends ClientRoutinesState {}

class RoutineLoading extends ClientRoutinesState {}

class RoutineLoadedSuccessfully extends ClientRoutinesState {
  final List<Routine> routines;

  RoutineLoadedSuccessfully(this.routines);
}

class RoutineNoData extends ClientRoutinesState {}

class RoutineError extends ClientRoutinesState {
  final String error;

  RoutineError(this.error);
}
