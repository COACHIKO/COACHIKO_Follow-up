import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/utils/constants/colors.dart';
import 'package:followupapprefactored/core/utils/helpers/helper_functions.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/models/routine_response.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/routing/routing_model/routing_model.dart';
import '../../../all_clients_display/data/models/clients_response.dart';
import '../../exercises_selection/data/models/exercisesDataBase.dart';
import '../../exercises_selection/ui/exercises_selection_page.dart';
import '../logic/cubit/client_routines_cubit.dart';
import '../logic/cubit/client_routines_state.dart';

class ClientRoutineDisplay extends StatelessWidget {
  final ClientData clientData;

  const ClientRoutineDisplay({
    super.key,
    required this.clientData,
  });

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);
    return BlocBuilder<ClientRoutinsCubit, ClientRoutinesState>(
      builder: (context, state) {
        if (state is RoutineLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RoutineError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is RoutineLoadedSuccessfully) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("${clientData.firstName}'s Routines"),
              iconTheme: const IconThemeData(color: Colors.blueAccent),
            ),
            body: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.routines.length,
                  itemBuilder: (context, index) {
                    Routine routine = state.routines[index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 160.h,
                          width: double.maxFinite,
                          child: Card(
                            color:
                                dark ? const Color(0xFF1C1C1E) : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        routine.routineName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          var cubit = context
                                              .read<ClientRoutinsCubit>();
                                          cubit.showCustomActionSheet(context,
                                              routine.routineId, clientData.id);
                                        },
                                        icon: const Icon(
                                          Icons.more_horiz,
                                          color: CColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    routine.exercises
                                        .map(
                                            (exercise) => exercise.exerciseName)
                                        .join(', '),
                                    style: const TextStyle(
                                        color: Color(0xFF989799)),
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    height: 55,
                                    width: double.maxFinite,
                                    child: routine.exercises[0].exerciseName ==
                                            ""
                                        ? ElevatedButton(
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ExercisesSelection(
                                                            clientData:
                                                                clientData,
                                                            routine: routine,
                                                          )));
                                            },
                                            child: const Text(
                                              'Add Exercise to The Routine',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: () async {
                                              List<Exercises>
                                                  addExercisesToList(
                                                      List<Exercise>
                                                          routineExercises) {
                                                List<Exercises>
                                                    selectedExercises = [];

                                                for (int i = 0;
                                                    i < routineExercises.length;
                                                    i++) {
                                                  selectedExercises
                                                      .add(Exercises(
                                                    exerciseID:
                                                        routineExercises[i]
                                                            .exerciseId
                                                            .toString(),
                                                    exerciseName:
                                                        routineExercises[i]
                                                            .exerciseName,
                                                    targetMuscles:
                                                        routineExercises[i]
                                                            .targetMuscles,
                                                    exerciseImage:
                                                        routineExercises[i]
                                                            .exerciseImage,
                                                    usedEquipment:
                                                        routineExercises[i]
                                                            .usedEquipment,
                                                    isSelected: true,
                                                  ));
                                                }

                                                return selectedExercises;
                                              }

                                              context.push(
                                                  Routes.exercisesAssignment,
                                                  extra: ExerciseAssignmentParams(
                                                      clientData: clientData,
                                                      routine: routine,
                                                      oldExercises:
                                                          addExercisesToList(
                                                              routine
                                                                  .exercises)));
                                            },
                                            child: const Text(
                                              'Preview Routine',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        state.routines.length - 1 == index
                            ? Center(
                                child: OutlinedButton(
                                  onPressed: () {
                                    var cubit =
                                        context.read<ClientRoutinsCubit>();
                                    cubit.showMyBottomSheet(
                                        context, clientData.id!);
                                  },
                                  child: const Text("Add Routine"),
                                ),
                              )
                            : Container()
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: MaterialButton(
              onPressed: () {
                var cubit = context.read<ClientRoutinsCubit>();
                cubit.showMyBottomSheet(context, clientData.id!);
              },
              child: const Text("Create Routine"),
            ),
          );
        }
      },
    );
  }
}
