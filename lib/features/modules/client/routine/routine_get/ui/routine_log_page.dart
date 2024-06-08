// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:followupapprefactored/core/utils/constants/image_strings.dart';
// import 'package:followupapprefactored/core/utils/helpers/helper_functions.dart';
// import 'package:followupapprefactored/view/widgets/custom_textformfield.dart';
// import 'package:get/get.dart';

// import '../data/models/routine_response.dart';

// class ExerciseLoggingPage extends StatefulWidget {
//   final Routine routine;

//   const ExerciseLoggingPage({
//     super.key,
//     required this.routine,
//   });

//   @override
//   ExerciseLoggingPageState createState() => ExerciseLoggingPageState();
// }

// class ExerciseLoggingPageState extends State<ExerciseLoggingPage> {
//   final ExerciseLoggingController exerciseLoggingController =
//       Get.put(ExerciseLoggingController());
//   List<int> numberOfSetsPerExercise = [];

//   @override
//   void initState() {
//     super.initState();
//     numberOfSetsPerExercise =
//         List<int>.filled(widget.routine.exercises.length, 0);
//     exerciseLoggingController.initializeExerciseLogs(widget);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var dark = THelperFunctions.isDarkMode(context);

//     return GetBuilder<ExerciseLoggingController>(
//       init: ExerciseLoggingController(),
//       builder: (controller) => Scaffold(
//         backgroundColor: dark ? Colors.black : Colors.white,
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: dark ? Colors.black : Colors.white,
//           title: Text(
//             '${controller.capitalize(widget.routine.routineName)} Workout',
//           ),
//           iconTheme: const IconThemeData(color: Colors.blueAccent),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 physics: const PageScrollPhysics(),
//                 itemCount: widget.routine.exercises.length,
//                 itemBuilder: (context, indexx) {
//                   Exercise exercise = widget.routine.exercises[indexx];
//                   return Column(
//                     children: [
//                       ListTile(
//                         leading: CircleAvatar(
//                           radius: 25,
//                           child: ClipOval(
//                             child: Image(
//                               image: AssetImage(TImages.excersiseDirectory +
//                                   exercise.exerciseImage),
//                             ),
//                           ),
//                         ),
//                         title: Text(
//                           exercise.exerciseName,
//                           style: const TextStyle(
//                             fontSize: 19,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.only(left: 16),
//                         child: const TextField(
//                           decoration: InputDecoration(
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             border: InputBorder.none,
//                             focusColor: Color(0xff505050),
//                             hintStyle: TextStyle(
//                               fontSize: 16,
//                               color: Color(0xFF959595),
//                             ),
//                             hintText: 'Add routine notes here',
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.only(left: 16),
//                         child: Row(
//                           children: [
//                             const Icon(
//                               CupertinoIcons.timer,
//                               color: Colors.blue,
//                               size: 22,
//                             ),
//                             Text(
//                               " Rest Timer: ${controller.isClicked.value && indexx < controller.restSecondsList.length ? '${controller.restSecondsList[indexx].value ~/ 60} min ${controller.restSecondsList[indexx].value % 60} sec' : '${exercise.rest} min'}",
//                               style: const TextStyle(
//                                   color: Colors.blue, fontSize: 18),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Column(
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 8),
//                             child: const Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "SET",
//                                   style: TextStyle(color: Color(0xFF959595)),
//                                 ),
//                                 Text(
//                                   "PREVIOUS",
//                                   style: TextStyle(color: Color(0xFF959595)),
//                                 ),
//                                 Text(
//                                   "RIR",
//                                   style: TextStyle(color: Color(0xFF959595)),
//                                 ),
//                                 Text(
//                                   "REPS",
//                                   style: TextStyle(color: Color(0xFF959595)),
//                                 ),
//                                 Icon(
//                                   Icons.check_sharp,
//                                   color: Color(0xFF959595),
//                                 )
//                               ],
//                             ),
//                           ),
//                           ListView.builder(
//                             physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: exercise
//                                 .sets, // Use the number of sets from the exercise object
//                             itemBuilder: (context, setIndex) {
//                               ExerciseLog exerciseLog = controller
//                                       .exerciseLogs[indexx][
//                                   setIndex]; // Access exercise log based on index

//                               return Container(
//                                 color: exerciseLog.iscomplete
//                                     ? const Color(0xFF2C6111)
//                                     : Colors.black,
//                                 child: Container(
//                                   margin:
//                                       const EdgeInsets.symmetric(horizontal: 9),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         margin: const EdgeInsets.only(left: 8),
//                                         child: Text(
//                                           "${setIndex + 1}",
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             color:
//                                                 exerciseLog.iscomplete == false
//                                                     ? const Color(0xFF959595)
//                                                     : Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: Container(
//                                           margin: const EdgeInsets.only(
//                                               left: 70, top: 0),
//                                           alignment: Alignment.center,
//                                           child: CustomWeightInput(
//                                               isComplete:
//                                                   exerciseLog.iscomplete,
//                                               hintText: "-"),
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: Container(
//                                           margin: const EdgeInsets.only(
//                                               left: 70, top: 0),
//                                           alignment: Alignment.center,
//                                           child: CustomWeightInput(
//                                               isComplete:
//                                                   exerciseLog.iscomplete,
//                                               hintText: "-"),
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: Container(
//                                           margin: const EdgeInsets.only(
//                                               left: 40, top: 0),
//                                           child: CustomWeightInput(
//                                               isComplete:
//                                                   exerciseLog.iscomplete,
//                                               hintText: "-"),
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () => controller.toggleTimer(
//                                             indexx, setIndex, widget),
//                                         child: Icon(
//                                           exerciseLog.iscomplete
//                                               ? Icons.stop
//                                               : Icons.play_arrow,
//                                           color: exerciseLog.iscomplete
//                                               ? Colors.green
//                                               : const Color(0xFF959595),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                       MaterialButton(
//                         onPressed: () {},
//                         child: Text("data"),
//                       ),
//                       const Divider(
//                         thickness: .09,
//                         color: Colors.blueAccent,
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ExerciseLog {
//   String reps = '';
//   String weight = '';
//   bool iscomplete = false;
//   int restTimer = 0;
// }

// class ExerciseLoggingController extends GetxController {
//   static ExerciseLoggingController get instance => Get.find();

//   RxBool isClicked = false.obs; // Track timer toggle state
//   final List<List<ExerciseLog>> exerciseLogs = []; // Exercise logs
//   final List<RxInt> restSecondsList = []; // Remaining rest seconds
//   final List<Timer?> restTimers = []; // Timers for each exercise

//   /// Initializes exercise logs based on provided routine data.
//   void initializeExerciseLogs(ExerciseLoggingPage widget) {
//     if (isValidData(widget)) {
//       for (var exercise in widget.routine.exercises) {
//         exerciseLogs.add(List.generate(
//           exercise.sets, // Use sets from each exercise
//           (setIndex) => ExerciseLog(),
//         ));
//         restSecondsList.add(RxInt(exercise.rest * 60)); // Initialize rest time
//         restTimers.add(null); // Initialize timer slot
//       }
//     } else {
//       // Handle invalid data (empty sets or rest durations)
//       //print('Warning: Invalid data provided. Check sets and rest durations.');
//     }
//   }

//   /// Validates if required data (sets and rest durations) is present.
//   bool isValidData(ExerciseLoggingPage widget) {
//     return widget.routine.exercises
//         .every((exercise) => exercise.sets > 0 && exercise.rest >= 0);
//   }

//   /// Starts timer for the specified exercise and set.
//   void timerStart(int numOfSec, int exerciseIndex) {
//     restSecondsList[exerciseIndex].value = numOfSec;
//     restTimers[exerciseIndex]?.cancel(); // Cancel existing timer

//     restTimers[exerciseIndex] =
//         Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (restSecondsList[exerciseIndex].value > 0) {
//         restSecondsList[exerciseIndex]--;
//         update();
//       } else {
//         timer.cancel();
//         onTimerFinish(
//             numOfSec, exerciseIndex); // Perform action when timer ends
//       }
//     });
//   }

//   /// Action to be performed when the timer finishes (e.g., notification).
//   void onTimerFinish(int numOfSec, int exerciseIndex) {
//     // final notificationService = NotificationService(); // (Assuming notification service implementation)
//   }

//   /// Toggles timer for the specified exercise and set.
//   void toggleTimer(
//       int exerciseIndex, int setIndex, ExerciseLoggingPage widget) {
//     ExerciseLog exerciseLog = exerciseLogs[exerciseIndex][setIndex];
//     exerciseLog.iscomplete = !exerciseLog.iscomplete; // Toggle completion state

//     if (exerciseLog.iscomplete) {
//       // Cancel previous timers if any
//       for (var timer in restTimers) {
//         timer?.cancel();
//       }

//       isClicked.value = true;
//       timerStart(
//           widget.routine.exercises[exerciseIndex].rest * 60, exerciseIndex);
//     } else {
//       // Stop the timer when exercise is marked incomplete or rest not provided
//       restTimers[exerciseIndex]?.cancel();
//       restSecondsList[exerciseIndex].value =
//           widget.routine.exercises[exerciseIndex].rest *
//               60; // Reset remaining time
//     }

//     update(); // Update UI
//   }

//   /// Capitalizes the first letter of a string.
//   String capitalize(String text) {
//     if (text.isEmpty) {
//       return text;
//     }
//     return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
//   }

//   /// Regenerates exercise logs based on updated number of sets for an exercise.
//   void regenerateExerciseLogs(
//       ExerciseLoggingPage widget, int exerciseIndex, int newNumberOfSets) {
//     // Clear existing exercise logs for the exercise
//     exerciseLogs[exerciseIndex].clear();

//     // Regenerate exercise logs based on newNumberOfSets
//     for (int i = 0; i < newNumberOfSets; i++) {
//       ExerciseLog newExerciseLog = ExerciseLog();
//       // You can set initial values or leave them blank as per your requirement
//       exerciseLogs[exerciseIndex].add(newExerciseLog);
//     }
//   }
// }
