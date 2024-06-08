import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:followupapprefactored/view/widgets/custom_appbar.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/helpers/helper_functions.dart';
import '../data/models/routine_response.dart';
import '../logic/cubit/routine_cubit.dart';
import '../logic/cubit/routine_state.dart';

class WorkoutPlanPage extends StatelessWidget {
  const WorkoutPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const CustomAppBar(showBackArrow: false, title: "Workout"),
      body: BlocBuilder<RoutineCubit, RoutineState>(
        builder: (context, state) {
          if (state is RoutineLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoutineError) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is RoutineLoadedSuccessfully) {
            if (state.routines[0].exercises[0].exerciseName == "") {
              return const Center(child: Text('No routines available'));
            } else {
              return ListView.builder(
                itemCount: state.routines.length,
                itemBuilder: (context, index) {
                  Routine routine = state.routines[index];
                  return SafeArea(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 160,
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
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: MaterialButton(
                                      shape: const OutlineInputBorder(
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(5),
                                          right: Radius.circular(5),
                                        ),
                                      ),
                                      onPressed: () async {
                                        BlocProvider.of<RoutineCubit>(context)
                                            .startRoutine(routine);
                                        //print(myServices.sharedPreferences.getInt("currentStep"));
                                      },
                                      color: CColors.primary,
                                      child: const Text(
                                        'Start Routine',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          } else {
            return Container(); // handle other states if needed
          }
        },
      ),
    );
  }
}
