import 'dart:async';
import 'package:get/get.dart';
import '../core/notification/notfication.dart';
import '../view/screens/client_area/routine_log_page.dart';

class ExerciseLoggingController extends GetxController {
  static ExerciseLoggingController get instance => Get.find();

  RxBool isClicked = false.obs;
  List<List<ExerciseLog>> exerciseLogs = [];
  List<RxInt> restSecondsList = [];
  List<Timer?> restTimers = [];
  RxInt excernum = 0.obs;

  void initializeExerciseLogs(ExerciseLoggingPage widget) {
    if (isValidData(widget)) {
      exerciseLogs = List.generate(
        widget.exercises.length,
            (exerciseIndex) => List.generate(
          widget.setsPerExercise[exerciseIndex],
              (setIndex) => ExerciseLog(),
        ),
      );

      // Initialize restSeconds and restTimers for each workout
      restSecondsList = List.generate(
        widget.exercises.length,
            (index) => (widget.rest[index] * 60).obs,
      );
      restTimers = List.generate(widget.exercises.length, (_) => null); // Initialize timers list
    } else {
      // Handle the case where setsPerExercise or lastWeights are not provided or are empty
      // You might want to provide default values or show an error message.
    }
  }

  bool isValidData(ExerciseLoggingPage widget) {
    return widget.setsPerExercise.isNotEmpty &&
        widget.lastWeights.isNotEmpty &&
        widget.rest.isNotEmpty; // Ensure rest durations are provided
  }

  void timerStart(int numOfSec, int index) {
    restSecondsList[index].value = numOfSec;
    restTimers[index]?.cancel(); // Cancel the existing timer if any

    restTimers[index] = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (restSecondsList[index] > 0) {
        restSecondsList[index]--;
        update();
      } else {
        timer.cancel();
        // Perform the action when the timer finishes here
        // For example, you can add a callback function to execute
        // You might want to perform some action like showing a notification, playing a sound, etc.
        onTimerFinish(numOfSec, index); // Call a function when the timer finishes
      }
    });
  }

  // Add a function to execute when the timer finishes
  void onTimerFinish(int numOfSec, int index) {
    final notificationService = NotificationService(); // Create an instance
    notificationService.showNotification(
      title: "Your Rest Is Over.",
      body: "Time To Lift More.",
    );
  }

  void toggleTimer(int index, int setIndex, ExerciseLoggingPage widget) {
    ExerciseLog exerciseLog = exerciseLogs[index][setIndex];
    exerciseLog.iscomplete = !exerciseLog.iscomplete;

    if (exerciseLog.iscomplete) {
      // Cancel previous timers if any
      for (var timer in restTimers) {
        timer?.cancel();
      }

      isClicked.value = true;
      timerStart(widget.rest[index] * 60, index); // Start timer for the current exercise index
    } else {
      // Stop the timer when exercise is marked as incomplete or if no rest duration is provided
      restTimers[index]?.cancel();
      restSecondsList[index].value = widget.rest[index] * 60; // Reset remaining time
    }

    update();
  }

  String capitalize(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
  }

}
