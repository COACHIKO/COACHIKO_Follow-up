import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_log/data/models/routine_log_request_body.dart';
import '../../../routine_get/data/models/routine_response.dart';
import '../../data/repository/routine_log_repo_impl.dart';

part 'routine_log_event.dart';
part 'routine_log_state.dart';

class RoutineWeightLogCubit extends Cubit<RoutineWeightLogState> {
  RoutineWeightLogCubit(this.routineLogRepoImp)
      : super(RoutineWeightLogInitial());
  final RoutineLogRepoImp routineLogRepoImp;

  late Routine _routine;
  List<List<bool>> isFinishedLists = [];
  List<List<String>> weights = [];
  List<List<String>> reps = [];
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
    weights = List.generate(
      routine.exercises.length,
      (exerciseIndex) => List.generate(
        routine.exercises[exerciseIndex].sets,
        (setIndex) => '',
      ),
    );
    reps = List.generate(
      routine.exercises.length,
      (exerciseIndex) => List.generate(
        routine.exercises[exerciseIndex].sets,
        (setIndex) => '',
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
    restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

  void updateWeight(int exerciseIndex, int setIndex, String weight) {
    weights[exerciseIndex][setIndex] = weight;
  }

  void updateReps(int exerciseIndex, int setIndex, String rep) {
    reps[exerciseIndex][setIndex] = rep;
  }

  String printRestTime() {
    int minutes = restTimeLeft ~/ 60;
    int seconds = restTimeLeft % 60;
    return ' Time left: $minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> submitAndLogRoutine(int userId, routineId) async {
    try {
      // Collect all routine log entries
      List<RoutineLogRequestBody> exerciseLogs = [];
      for (var exerciseIndex = 0;
          exerciseIndex < _routine.exercises.length;
          exerciseIndex++) {
        var exercise = _routine.exercises[exerciseIndex];
        for (var setIndex = 0; setIndex < exercise.sets; setIndex++) {
          if (isFinishedLists[exerciseIndex][setIndex] &&
              weights[exerciseIndex][setIndex].isNotEmpty &&
              reps[exerciseIndex][setIndex].isNotEmpty) {
            exerciseLogs.add(
              RoutineLogRequestBody(
                userId: userId,
                exerciseId: exercise.exerciseId,
                routineId: routineId,
                weight: weights[exerciseIndex][setIndex],
                reps: reps[exerciseIndex][setIndex],
              ),
            );
          }
        }
      }

      // Submit each log entry
      for (var log in exerciseLogs) {
        var response = await routineLogRepoImp.routineLog(log);
        if (response.status == true) {
          showToast(response.message);
        }
      }
    } catch (e) {
      showToast(e.toString());
    }
  }

  @override
  Future<void> close() {
    restTimer?.cancel();
    return super.close();
  }
}

// class ExerciseLog {
//   final int userId;
//   final int exerciseId;
//   final String weight;
//   final String reps;

//   ExerciseLog({
//     required this.userId,
//     required this.exerciseId,
//     required this.weight,
//     required this.reps,
//   });

//   Map<String, dynamic> toJson() => {
//         "user_id": userId,
//         "exercise_id": exerciseId,
//         "weight": weight,
//         "reps": reps,
//       };
// }
