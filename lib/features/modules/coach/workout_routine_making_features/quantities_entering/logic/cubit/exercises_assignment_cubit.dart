// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../data/repository/exercises_assignment_repo_imp.dart';
// import 'exercises_assignment_state.dart';

// class ExerciseAssignmentCubit extends Cubit<ExercisesAssignmentStates> {
//   final ExercisesAssignmentRepoImp exercisesAssignmentRepoImp;
//   final int lenth;
//   List<TextEditingController> setsControllers = [];
//   List<TextEditingController> repsControllers = [];
//   List<TextEditingController> restControllers = [];

//   ExerciseAssignmentCubit({
//     required this.exercisesAssignmentRepoImp,
//     required this.lenth,
//   }) : super(FoodQuantitiesInitialState()) {
//     for (int i = 0; i < lenth; i++) {
//       var controller = TextEditingController();

//       setsControllers.add(controller);
//       repsControllers.add(controller);
//       restControllers.add(controller);
//     }
//   }
// }
