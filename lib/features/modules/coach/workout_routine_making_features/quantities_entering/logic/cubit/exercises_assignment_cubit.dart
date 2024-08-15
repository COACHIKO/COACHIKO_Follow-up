import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../client/routine/routine_get/data/models/routine_response.dart';
import '../../../../all_clients_display/data/models/clients_response.dart';
import '../../../exercises_selection/data/models/exercisesDataBase.dart';
import '../../data/models/exercises_assignment_request_body.dart';
import '../../data/repository/exercises_assignment_repo_imp.dart';
import 'exercises_assignment_state.dart';

class ExerciseAssignmentCubit extends Cubit<ExercisesAssignmentStates> {
  final ClientData clientData;
  final Routine routine;
  final List<Exercises> selectedExercises;
  final ExercisesAssignmentRepoImp exercisesAssignmentRepoImp;
  List<GlobalKey<FormState>> formKeys = [];
  List<bool> formVisibilityStates = [];

  final formKey = GlobalKey<FormState>();
  List<TextEditingController> setsControllers = [];
  List<TextEditingController> repsControllers = [];
  List<TextEditingController> restControllers = [];
  List<TextEditingController> rirControllers = [];
  List<bool> expansionTileStates = [];
  ExerciseAssignmentCubit({
    required this.exercisesAssignmentRepoImp,
    required this.routine,
    required this.clientData,
    required this.selectedExercises,
  }) : super(FoodQuantitiesInitialState()) {
    for (int i = 0; i < selectedExercises.length; i++) {
      formKeys.add(GlobalKey<FormState>());
      setsControllers.add(TextEditingController());
      repsControllers.add(TextEditingController());
      restControllers.add(TextEditingController());
      rirControllers.add(TextEditingController());
      formVisibilityStates.add(false);
      expansionTileStates.add(false);
    }
  }

  ExerciseAssignmentRequestBody createExerciseAssignmentRequestBody() {
    List<ExerciseInsertionModel> exercisesData = [];
    for (int i = 0; i < selectedExercises.length; i++) {
      exercisesData.add(ExerciseInsertionModel(
        exerciseId: selectedExercises[i].exerciseID.toString(),
        sets: setsControllers[i].text,
        reps: repsControllers[i].text,
        rir: rirControllers[i].text,
        rest: restControllers[i].text,
      ));
    }

    return ExerciseAssignmentRequestBody(
      userId: clientData.id!.toString(),
      routineId: routine.routineId,
      exercises: exercisesData,
    );
  }

  void toggleFormVisibility(int index) {
    formVisibilityStates[index] = !formVisibilityStates[index];
    emit(ListShrinkedUpdateState());
  }

  bool areAllFormsVisible() {
    return formVisibilityStates.every((visible) => visible);
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  bool areTextFormFieldsValid() {
    for (int i = 0; i < selectedExercises.length; i++) {
      if (!formKeys[i].currentState!.validate()) {
        return false;
      }
    }
    return true;
  }

  Future<void> assignExercises() async {
    try {
      var response = await exercisesAssignmentRepoImp
          .assignExercises(createExerciseAssignmentRequestBody());
      if (response.message == "Exercises Inserted") {
        showToast(response.message.toString());
      }
    } catch (e) {
      emit(FoodsStateErrors(e.toString()));
    }
  }

  List<Exercises> addExercisesToList(List<Exercise> routineExercises) {
    List<Exercises> selectedExercises = [];

    for (int i = 0; i < routineExercises.length; i++) {
      selectedExercises.add(Exercises(
        exerciseID: routineExercises[i].exerciseId.toString(),
        exerciseName: routineExercises[i].exerciseName,
        targetMuscles: routineExercises[i].targetMuscles,
        exerciseImage: routineExercises[i].exerciseImage,
        usedEquipment: routineExercises[i].usedEquipment,
        isSelected: true,
      ));
    }
    return selectedExercises;
  }

  List<String> getSelectedExerciseIds() {
    List<String> selectedIds = [];
    for (int i = 0; i < selectedExercises.length; i++) {
      selectedIds.add(selectedExercises[i].exerciseID.toString());
    }
    return selectedIds;
  }

  void removeExercise(int index) {
    selectedExercises.removeAt(index);
    formVisibilityStates.removeAt(index);
    formKeys.removeAt(index);
    setsControllers.removeAt(index);
    repsControllers.removeAt(index);
    restControllers.removeAt(index);
    rirControllers.removeAt(index);
    expansionTileStates.removeAt(index);
    emit(ListShrinkedUpdateState());
  }
}
