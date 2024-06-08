// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../../client/routine/routine_get/data/models/routine_response.dart';
// import '../../../../display_client_routine/data/models/routine_crud_request_body.dart';
// import '../../data/repository/edit_routines_repo_impl.dart';
// import 'edit_routine_state.dart';

// class EditRoutineCubit extends Cubit<EditRoutineState> {
//   final Routine routine;
//   final EditRoutineRepoImp editRoutineRepoImp;
//   EditRoutineCubit({
//     required this.editRoutineRepoImp,
//     required this.routine,
//   }) : super(EditRoutineInitial());

//   TextEditingController routineName = TextEditingController();
//   void updateRoutine(Routine routine) {
//     emit(EditRoutineUpdate(routine));
//   }

//   Future<void> updateRoutineName(String routineName, int routineId) async {
//     try {
//       await editRoutineRepoImp.updateRoutineName(RoutineUpdateRequestBody(
//           routineName: routineName, routineId: routineId));
//       //  showToast(response.message);
//     } catch (e) {
//       emit(EditRoutineError(e.toString()));
//     }
//   }
// }
