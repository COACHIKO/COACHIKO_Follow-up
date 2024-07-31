import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void startRoutine(Routine routine, context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            RoutineWeightLogScreen(routine: routine),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 250),
      ),
    );
  }
}
