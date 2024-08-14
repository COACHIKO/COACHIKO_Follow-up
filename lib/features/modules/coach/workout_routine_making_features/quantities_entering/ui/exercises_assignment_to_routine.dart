import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/display_client_routine/ui/client_routines_display.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/exercises_selection/ui/exercises_selection_page.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/quantities_entering/data/repository/exercises_assignment_repo_imp.dart';
import '../../../../../../core/utils/constants/image_strings.dart';
import '../../../../../../core/utils/validators/validation.dart';
import '../../../../client/routine/routine_get/data/models/routine_response.dart';
import '../../../all_clients_display/data/models/clients_response.dart';
import '../../exercises_selection/data/models/exercisesDataBase.dart';
import '../data/models/exercises_assignment_request_body.dart';

class Exercisesassignment extends StatelessWidget {
  final ClientData clientData;
  final Routine routine;
  final List<Exercises> selectedExercises;

  const Exercisesassignment({
    super.key,
    required this.clientData,
    required this.selectedExercises,
    required this.routine,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Enter Sets & Reps'),
        iconTheme: const IconThemeData(color: Colors.blueAccent),
      ),
      body: BlocProvider(
        create: (context) => ExerciseAssignmentCubit(
          clientData: clientData,
          routine: routine,
          exercisesAssignmentRepoImp:
              ExercisesAssignmentRepoImp(ApiService(Dio())),
          selectedExercises: selectedExercises,
        ),
        child: const ExercisesassignmentBody(),
      ),
    );
  }
}

abstract class ExercisesAssignmentStates {}

class FoodQuantitiesInitialState extends ExercisesAssignmentStates {}

class ListShrinkedUpdateState extends ExercisesAssignmentStates {
  ListShrinkedUpdateState();
}

class FoodsStateErrors extends ExercisesAssignmentStates {
  final String error;

  FoodsStateErrors(this.error);
}

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

class ExercisesassignmentBody extends StatelessWidget {
  const ExercisesassignmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseAssignmentCubit, ExercisesAssignmentStates>(
      builder: (context, state) {
        final cubit = BlocProvider.of<ExerciseAssignmentCubit>(context);
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: ReorderableListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: cubit.selectedExercises.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(
                          cubit.selectedExercises[index].exerciseID.toString()),
                      onDismissed: (direction) {
                        cubit.removeExercise(index);
                      },
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      child: Card(
                        key: Key(cubit.selectedExercises[index].exerciseID
                            .toString()),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    child: ClipOval(
                                      child: Image(
                                        image: AssetImage(
                                          TImages.excersiseDirectory +
                                              cubit.selectedExercises[index]
                                                  .exerciseImage,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      cubit.selectedExercises[index]
                                          .exerciseName,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(Icons.more_horiz),
                                  ),
                                ],
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                splashFactory: NoSplash.splashFactory,
                                onTap: () {
                                  cubit.toggleFormVisibility(index);
                                },
                                child: Icon(
                                  cubit.formVisibilityStates[index]
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                ),
                              ),
                              const SizedBox(height: 10),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: cubit.formVisibilityStates[index]
                                    ? 1.0
                                    : 0.0,
                                child: cubit.formVisibilityStates[index]
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 22.0),
                                        child: Form(
                                          key: cubit.formKeys[index],
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Enter Sets"),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: CValidator
                                                          .validateSets,
                                                      controller:
                                                          cubit.setsControllers[
                                                              index],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Enter Reps"),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: CValidator
                                                          .validateReps,
                                                      controller:
                                                          cubit.repsControllers[
                                                              index],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                      "Enter Rest Time in minutes"),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: CValidator
                                                          .validateRest,
                                                      controller:
                                                          cubit.restControllers[
                                                              index],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                      "Enter Reps In Reserve (RIR)"),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: CValidator
                                                          .validateRir,
                                                      controller:
                                                          cubit.rirControllers[
                                                              index],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  onReorder: (oldIndex, newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final exercise = cubit.selectedExercises.removeAt(oldIndex);
                    cubit.selectedExercises.insert(newIndex, exercise);
                    cubit.formVisibilityStates.insert(newIndex,
                        cubit.formVisibilityStates.removeAt(oldIndex));
                    cubit.formKeys
                        .insert(newIndex, cubit.formKeys.removeAt(oldIndex));
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExercisesSelection(
                          clientData: cubit.clientData,
                          routine: cubit.routine,
                          lastSelectedExercises: cubit.getSelectedExerciseIds(),
                        ),
                      ),
                    );
                  },
                  child: const Text("Add Exercise to The Routine"),
                ),
              ),
              if (cubit.areAllFormsVisible() &&
                  cubit.selectedExercises.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (cubit.areTextFormFieldsValid() == true) {
                        await cubit.assignExercises();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientRoutineDisplay(
                              clientData: cubit.clientData,
                            ),
                          ),
                          (route) => false,
                        );
                      } else {}
                    },
                    child: const Text("Submit Routine"),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
