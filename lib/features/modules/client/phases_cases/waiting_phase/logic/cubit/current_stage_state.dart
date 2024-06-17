import '../../data/models/current_stage_response.dart';

abstract class CurrentStageState {}

class CurrentStageInitial extends CurrentStageState {}

class CurrentStageLoading extends CurrentStageState {}

class CurrentStageUpdate extends CurrentStageState {
  final CurrentStageResponse currentStage;

  CurrentStageUpdate(this.currentStage);
}

class ExpansionStateUpdate extends CurrentStageState {
  ExpansionStateUpdate();
}

class CurrentStageError extends CurrentStageState {
  final String error;

  CurrentStageError(this.error);
}
