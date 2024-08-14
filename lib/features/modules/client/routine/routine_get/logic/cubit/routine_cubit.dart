import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../core/app_router.dart';
import '../../../../../../../core/services/shared_pref/shared_pref.dart';
import '../../data/models/routine_request_body.dart';
import '../../data/models/routine_response.dart';
import '../../data/repository/routine_repo_impl.dart';
import 'routine_state.dart';

class RoutineCubit extends Cubit<RoutineState> {
  final RoutineRepoImp routineRepoImp;
  RoutineCubit({required this.routineRepoImp}) : super(RoutineInitial());

  Future<void> getRoutine() async {
    try {
      emit(RoutineLoading());
      var routines = await routineRepoImp.getRoutine(
          RoutineRequestBody(user: SharedPref().getInt("user")!.toString()));

      if (routines.isEmpty) {
        emit(RoutineNoData());
      } else {
        emit(RoutineLoadedSuccessfully(routines));
      }
    } catch (e) {
      emit(RoutineError(e.toString()));
    }
  }

  void startRoutine(Routine routine, BuildContext context) {
    context.push(
      Routes.routineLog,
      extra: routine,
    );
  }
}
