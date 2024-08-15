import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/routing/routes.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/display_client_routine/ui/client_routines_display.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/routing/routing_model/routing_model.dart';
import '../../../../../../core/utils/constants/image_strings.dart';
import '../../../../../../core/utils/validators/validation.dart';
import '../logic/cubit/exercises_assignment_cubit.dart';
import '../logic/cubit/exercises_assignment_state.dart';

class Exercisesassignment extends StatelessWidget {
  const Exercisesassignment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseAssignmentCubit, ExercisesAssignmentStates>(
      builder: (context, state) {
        final cubit = BlocProvider.of<ExerciseAssignmentCubit>(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Enter Sets & Reps'),
            iconTheme: const IconThemeData(color: Colors.blueAccent),
          ),
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
                  onPressed: () {
                    context.pushReplacement(Routes.exerciseSelection,
                        extra: ExerciseSelectionParams(
                          clientData: cubit.clientData,
                          routine: cubit.routine,
                          oldExercises: cubit.getSelectedExerciseIds(),
                        ));
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
