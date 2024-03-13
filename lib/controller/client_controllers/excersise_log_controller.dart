import 'dart:async';
import 'package:get/get.dart';
import '../../core/notification/notfication.dart';
import '../../view/screens/client_area/routine_screens/routine_log_page.dart';

class ExerciseLoggingController extends GetxController {
  static ExerciseLoggingController get instance => Get.find();

  RxBool isClicked = false.obs; // Track timer toggle state
  final List<List<ExerciseLog>> exerciseLogs = []; // Exercise logs
  final List<RxInt> restSecondsList = []; // Remaining rest seconds
  final List<Timer?> restTimers = []; // Timers for each exercise

  /// Initializes exercise logs based on provided routine data.
  void initializeExerciseLogs(ExerciseLoggingPage widget) {
    if (isValidData(widget)) {
      for (var exercise in widget.routine.exercises) {
        exerciseLogs.add(List.generate(
          exercise.sets, // Use sets from each exercise
              (setIndex) => ExerciseLog(),
        ));
        restSecondsList.add(RxInt(exercise.rest * 60)); // Initialize rest time
        restTimers.add(null); // Initialize timer slot
      }
    } else {
      // Handle invalid data (empty sets or rest durations)
      print('Warning: Invalid data provided. Check sets and rest durations.');
    }
  }

  /// Validates if required data (sets and rest durations) is present.
  bool isValidData(ExerciseLoggingPage widget) {
    return widget.routine.exercises.every((exercise) =>
    exercise.sets > 0 && exercise.rest >= 0);
  }

  /// Starts timer for the specified exercise and set.
  void timerStart(int numOfSec, int exerciseIndex) {
    restSecondsList[exerciseIndex].value = numOfSec;
    restTimers[exerciseIndex]?.cancel(); // Cancel existing timer

    restTimers[exerciseIndex] = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (restSecondsList[exerciseIndex].value > 0) {
        restSecondsList[exerciseIndex]--;
        update();
      } else {
        timer.cancel();
        onTimerFinish(numOfSec, exerciseIndex); // Perform action when timer ends
      }
    });
  }

  /// Action to be performed when the timer finishes (e.g., notification).
  void onTimerFinish(int numOfSec, int exerciseIndex) {
    final notificationService = NotificationService(); // (Assuming notification service implementation)
    notificationService.showNotification(
      title: "Your Rest Is Over.",
      body: "Time To Lift More.",
    );
  }

  /// Toggles timer for the specified exercise and set.
  void toggleTimer(int exerciseIndex, int setIndex, ExerciseLoggingPage widget) {
    ExerciseLog exerciseLog = exerciseLogs[exerciseIndex][setIndex];
    exerciseLog.iscomplete = !exerciseLog.iscomplete; // Toggle completion state

    if (exerciseLog.iscomplete) {
      // Cancel previous timers if any
      for (var timer in restTimers) {
        timer?.cancel();
      }

      isClicked.value = true;
      timerStart(widget.routine.exercises[exerciseIndex].rest * 60, exerciseIndex);
    } else {
      // Stop the timer when exercise is marked incomplete or rest not provided
      restTimers[exerciseIndex]?.cancel();
      restSecondsList[exerciseIndex].value =
          widget.routine.exercises[exerciseIndex].rest * 60; // Reset remaining time
    }

    update(); // Update UI
  }

  /// Capitalizes the first letter of a string.
  String capitalize(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Regenerates exercise logs based on updated number of sets for an exercise.
  void regenerateExerciseLogs(
      ExerciseLoggingPage widget, int exerciseIndex, int newNumberOfSets) {
    // Clear existing exercise logs for the exercise
    exerciseLogs[exerciseIndex].clear();

    // Regenerate exercise logs based on newNumberOfSets
    for (int i = 0; i < newNumberOfSets; i++) {
      ExerciseLog newExerciseLog = ExerciseLog();
      // You can set initial values or leave them blank as per your requirement
      exerciseLogs[exerciseIndex].add(newExerciseLog);
    }}}
