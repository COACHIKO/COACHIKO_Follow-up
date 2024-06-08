import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../routine_get/data/models/routine_response.dart';

part 'routine_log_event.dart';
part 'routine_log_state.dart';

class RoutineWeightLogCubit extends Cubit<RoutineWeightLogState> {
  RoutineWeightLogCubit() : super(RoutineWeightLogInitial());

  late Routine _routine;
  List<List<bool>> isFinishedLists = [];
  Timer? restTimer;
  int restTimeLeft = 0;
  int focused = -1;

  void initializeRoutine(Routine routine) {
    _routine = routine;
    isFinishedLists = List.generate(
      routine.exercises.length,
      (exerciseIndex) => List.generate(
        routine.exercises[exerciseIndex].sets,
        (setIndex) => false,
      ),
    );
    emit(
      RoutineWeightLogLoaded(
        isFinishedLists: isFinishedLists,
        restTimeLeft: restTimeLeft,
        focused: focused,
      ),
    );
  }

  void startRestTimer(int restDuration) {
    restTimeLeft = restDuration * 60;
    restTimer?.cancel();
    restTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (restTimeLeft > 0) {
        restTimeLeft--;
      } else {
        restTimer?.cancel();
      }
      emit(
        RoutineWeightLogLoaded(
          isFinishedLists: isFinishedLists,
          restTimeLeft: restTimeLeft,
          focused: focused,
        ),
      );
    });
  }

  void updateExerciseLog(int exerciseIndex, int setIndex) {
    isFinishedLists[exerciseIndex][setIndex] =
        !isFinishedLists[exerciseIndex][setIndex];
    if (isFinishedLists[exerciseIndex][setIndex] == false) {
      restTimer?.cancel();
      focused = -1;
    } else {
      focused = exerciseIndex;
      startRestTimer(_routine.exercises[exerciseIndex].rest);
    }
    emit(
      RoutineWeightLogLoaded(
        isFinishedLists: isFinishedLists,
        restTimeLeft: restTimeLeft,
        focused: focused,
      ),
    );
  }

  String printRestTime() {
    int minutes = restTimeLeft ~/ 60;
    int seconds = restTimeLeft % 60;
    return ' Time left: $minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Future<void> close() {
    restTimer?.cancel();
    return super.close();
  }
}
