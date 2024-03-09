// // ignore_for_file: unused_import
//
// import 'dart:async';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:get/get.dart';
//
// import '../core/notification/notfication.dart';
// import '../data/model/routine_model.dart';
// import '../view/screens/client_area/routine_log_page.dart';
// import 'routines_page_controller.dart';
//
// class ExerciseLoggingController extends GetxController {
//   RoutinesPageController homeController = Get.put(RoutinesPageController());
//   // final String? routineName;
//   // final List<String>? exercises;
//   // final List<int>? setsPerExercise;
//   // final List<double>? lastWeights;
//   // final List<int>? rest;
//   // ExerciseLoggingController({
//   //   this.routineName,
//   //   this.exercises,
//   //   this.setsPerExercise,
//   //   this.lastWeights,
//   //   this.rest,
//   // });
//
//  // List<List<ExerciseLog>> exerciseLogs = [];
//   //
//   // Future<void> _showNotification() async {
//   //   await NotificationService.showNotification(
//   //     title: "Hello Champion",
//   //     body: "Time To Get Back To Work",
//   //     payload: {"1": "add30sec"},
//   //     actionButtons: [
//   //       NotificationActionButton(
//   //         key: 'add30sec',
//   //         label: 'Add 30 Sec',
//   //       ),
//   //       NotificationActionButton(
//   //         key: 'add60sec',
//   //         label: 'Add 60 Sec',
//   //       ),
//   //       NotificationActionButton(
//   //         key: 'gotopage',
//   //         label: 'Lets Go!',
//   //       ),
//   //     ],
//   //   );
//   // }
//   //
//   // timerstart(int numofsec, index, setindex) {
//   //   i = numofsec;
//   //   restTimer?.cancel(); // Cancel the existing timer
//   //
//   //   restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//   //     if (i > 0) {
//   //          i--;
//   //          update();
//   //      } else {
//   //       timer.cancel();
//   //       _showNotification();
//   //     }
//   //   });
//   // }
//   // void initializeExerciseLogs(widget) {
//   //   if (bo==true) {
//   //     exerciseLogs = List.generate(
//   //       widget.exercises!.length,
//   //           (exerciseIndex) => List.generate(
//   //         widget.setsPerExercise![exerciseIndex],
//   //             (setIndex) => ExerciseLog(),
//   //       ),
//   //     );
//   //   } else {
//   //     // Handle the case where setsPerExercise or lastWeights are not provided or are empty
//   //     // You might want to provide default values or show an error message.
//   //   }
//   // }
//   //
//
//
// }
//
//
