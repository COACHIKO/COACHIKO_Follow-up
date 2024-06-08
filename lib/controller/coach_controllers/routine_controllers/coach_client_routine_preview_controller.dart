// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../data/model/routine_models/workout_data_model.dart';
// import '../../../data/source/web_services/coach_web_services/coach_clientsRoutineID_get.dart';
// import '../../../data/source/web_services/coach_web_services/coach_routine_crud_service.dart';
// import '../../../data/source/web_services/databases_web_services/exercise_database_services/all_exercises_database_get_service.dart';

// class WorkoutPlanPreviewController extends GetxController {
//   AllExercisesDataBase allExercisesDataBase = AllExercisesDataBase();
//   Rx<WorkoutData?> clientRoutines = Rx<WorkoutData?>(null);
//   @override
//   void onInit() {
//     allExercisesDataBase.getExercises();
//     super.onInit();
//   }

//   GetRoutinesSpecificId getRoutinesSpecificId = GetRoutinesSpecificId();
//   CoachRoutineInsertion coachRoutineInsertion = CoachRoutineInsertion();
//   Future<void> fetchClientRoutines(int id) async {
//     try {
//       clientRoutines.value =
//           await getRoutinesSpecificId.getRoutineDataFSpecific(id);
//       update();
//     } catch (e) {
//       // Handle the error gracefully
//       clientRoutines.value = WorkoutData(routines: []);
//       update();
//     }
//     update();
//   }

//   void createRoutine(BuildContext context, int clientId) async {
//     TextEditingController controller = TextEditingController();

//     double bottomSheetHeight = MediaQuery.of(context).size.height * 0.55;

//     showModalBottomSheet(
//       context: context,
//       useSafeArea: true,
//       enableDrag: true,
//       isScrollControlled: true,
//       builder: (context) => StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//           return SingleChildScrollView(
//             reverse: true,
//             child: Container(
//               height: bottomSheetHeight,
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextFormField(
//                     controller: controller,
//                     decoration: const InputDecoration(
//                       labelText: 'Routine Name',
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       SizedBox(
//                         width: 150,
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await coachRoutineInsertion.routineInsertion(
//                                 clientId, controller.text);
//                             fetchClientRoutines(clientId);
//                             update();
//                             Get.back();
//                           },
//                           child: const Text("Confirm"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }



//   @override
//   void onClose() {
//     clientRoutines.close();
//     super.onClose();
//   }
// }
