import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/models/routine_response.dart';

abstract class EditRoutineState {}

class EditRoutineInitial extends EditRoutineState {}

class EditRoutineUpdate extends EditRoutineState {
  final Routine routines;

  EditRoutineUpdate(this.routines);
}

class EditRoutineNoData extends EditRoutineState {}

class EditRoutineError extends EditRoutineState {
  final String error;

  EditRoutineError(this.error);
}
