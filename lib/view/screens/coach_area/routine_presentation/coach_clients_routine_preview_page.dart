// import 'package:flutter/material.dart';
// import 'package:followupapprefactored/core/utils/constants/colors.dart';
// import 'package:get/get.dart';
// import '../../../../controller/coach_controllers/routine_controllers/coach_client_routine_preview_controller.dart';
// import '../../../../core/utils/helpers/helper_functions.dart';
// import '../../../../data/model/routine_models/routine_model.dart';
// import '../../../../features/modules/client/features/routine/data/models/routine_response.dart';
// import '../../../widgets/custom_appbar.dart';
// import 'exercise_edit_page.dart';
// import 'exercise_search_page.dart';

// class WorkoutPlanPreview extends StatelessWidget {
//   final int id;

//   const WorkoutPlanPreview({
//     super.key,
//     required this.id,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(WorkoutPlanPreviewController());

//     return GetBuilder<WorkoutPlanPreviewController>(
//       init: controller,
//       initState: (workoutPlanController) {
//         controller.fetchClientRoutines(id);
//       },
//       builder: (workoutPlanController) => Scaffold(
//         appBar: const CustomAppBar(showBackArrow: true, title: "Workout"),
//         body: workoutPlanController.clientRoutines.value == null
//             ? const Center(child: CircularProgressIndicator())
//             : workoutPlanController.clientRoutines.value!.routines.isEmpty
//                 ? _buildEmptyState(context, controller)
//                 : _buildRoutinesList(context,
//                     workoutPlanController.clientRoutines.value!.routines),
//       ),
//     );
//   }

//   Widget _buildEmptyState(
//       BuildContext context, WorkoutPlanPreviewController controller) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const Center(child: Text('No Routines available for this Client')),
//             MaterialButton(
//               onPressed: () => controller.createRoutine(context, id),
//               child: const Text("Create Routine"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRoutinesList(
//     BuildContext context,
//     List<Routine> routines,
//   ) {
 
 
//     return ListView.builder(
//       itemCount: routines.length,
//       itemBuilder: (context, index) {
//         Routine routine = routines[index];
//         return SafeArea(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 160,
//                 width: double.maxFinite,
//                 child: Card(
//                   color: THelperFunctions.isDarkMode(context)
//                       ? const Color(0xFF1C1C1E)
//                       : Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 15, vertical: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               routine.routineName,
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                             IconButton(
//                               onPressed: () async {
//                                 workoutPlanController.showCustomActionSheet(
//                                     context, routine.routineId, id);
//                                 workoutPlanController.update();
//                               },
//                               icon: const Icon(
//                                 Icons.more_horiz,
//                                 color: CColors.primary,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           routine.exercises
//                               .map((exercise) => exercise.exerciseName)
//                               .join(', '),
//                           style: const TextStyle(color: Color(0xFF989799)),
//                           maxLines: 1,
//                         ),
//                         const SizedBox(height: 5),
//                         routine.exercises[0].exerciseId.isNaN
//                             ? SizedBox(
//                                 width: double.maxFinite,
//                                 child: MaterialButton(
//                                   shape: const OutlineInputBorder(
//                                     borderRadius: BorderRadius.horizontal(
//                                       left: Radius.circular(5),
//                                       right: Radius.circular(5),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     Get.to(() => ExerciseSearchPage(
//                                           id: id,
//                                           routineId:
//                                               int.parse(routine.routineId),
//                                         ));
//                                   },
//                                   color: CColors.primary,
//                                   child: const Text(
//                                     "Add Exercise",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               )
//                             : SizedBox(
//                                 width: double.maxFinite,
//                                 child: MaterialButton(
//                                   shape: const OutlineInputBorder(
//                                     borderRadius: BorderRadius.horizontal(
//                                       left: Radius.circular(5),
//                                       right: Radius.circular(5),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     Get.to(() => EditExercisePage(
//                                           selectedExercises:
//                                               routine.exercises.toList(),
//                                           id: id.toString(),
//                                           routineId: routine.routineId,
//                                         ));
//                                   },
//                                   color: CColors.primary,
//                                   child: const Text(
//                                     "Edit Exercise",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }



// // // class SelectedExercisesPage extends StatelessWidget {
// // //   const SelectedExercisesPage({super.key, required this.selectedExercises});
// // //
// // //   final List<Exercise> selectedExercises;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Selected Exercises'),
// // //       ),
// // //       body: ListView.builder(
// // //         itemCount: selectedExercises.length,
// // //         itemBuilder: (context, index) {
// // //           final exercise = selectedExercises[index];
// // //           return ListTile(
// // //             title: Text(exercise.exerciseName),
// // //             subtitle: Text(exercise.targetMuscles),
// // //             leading: ClipOval(
// // //               child: Image.asset(
// // //                 TImages.excersiseDirectory + exercise.exerciseImage,
// // //                 width: 50,
// // //               ),
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }
