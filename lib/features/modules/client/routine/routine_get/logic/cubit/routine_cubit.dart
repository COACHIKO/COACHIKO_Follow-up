import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../routine_log/ui/routine_weight_log.dart';
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
      var routines = await routineRepoImp
          .getRoutine(RoutineRequestBody(user: 1.toString()));

      if (routines.isEmpty) {
        emit(RoutineNoData());
      } else {
        emit(RoutineLoadedSuccessfully(routines));
      }
    } catch (e) {
      emit(RoutineError(e.toString()));
    }
  }

  void startRoutine(Routine routine) {
    Get.to(
      () => RoutineWeightLogScreen(routine: routine),
      duration: const Duration(milliseconds: 250),
    );
  }
}
