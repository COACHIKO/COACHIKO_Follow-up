// import 'dart:async';

// import 'package:dio/dio.dart';
// import 'package:followupapprefactored/core/networking/api_service.dart';
// import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/models/routine_request_body.dart';
// import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/models/routine_response.dart';
// import 'package:get/get.dart';
// import '../data/repository/routine_repo_impl.dart';
// import '../ui/routine_log_page.dart';

// class RoutineController extends GetxController {
//   final RoutineRepoImp routineRepoImp = RoutineRepoImp(ApiService(Dio()));

//   Future<List<Routine>> getRoutine() async {
//     var routines =
//         await routineRepoImp.getRoutine(RoutineRequestBody(user: "1"));
//     return routines;
//   }

//   Future<T> getFutureWithTimeout<T>(Future<T> future, Duration timeout) {
//     final completer = Completer<T>();
//     future.then((value) {
//       completer.complete(value);
//     }).catchError((error) {
//       completer.completeError(error);
//     });
//     Future.delayed(timeout, () {
//       if (!completer.isCompleted) {
//         completer.completeError('Timeout');
//       }
//     });
//     return completer.future;
//   }

//   void startRoutine(routine) {
//     Get.to(
//       () => ExerciseLoggingPage(routine: routine),
//       transition: Transition.size,
//       duration: const Duration(milliseconds: 250),
//     );
//   }
// }
