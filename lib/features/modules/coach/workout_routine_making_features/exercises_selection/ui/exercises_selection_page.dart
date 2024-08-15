import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/constants/image_strings.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import '../../../../../../core/utils/helpers/helper_functions.dart';
import '../../../../client/routine/routine_get/data/models/routine_response.dart';
import '../../../all_clients_display/data/models/clients_response.dart';
import '../data/models/exercisesDataBase.dart';
import '../logic/cubit/exercises_cubit.dart';
import '../logic/cubit/exercises_state.dart';

class ExercisesSelection extends StatelessWidget {
  final ClientData clientData;
  final Routine routine;

  const ExercisesSelection({
    super.key,
    required this.clientData,
    required this.routine,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectingExercisesCubit, ExercisesState>(
      builder: (context, state) {
        if (state is FoodsStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FoodsStateError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is LoadedSuccessfullyFoodsState) {
          List<Exercises> selectedFoods =
              context.read<SelectingExercisesCubit>().selectedFoods();
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Exercises'),
              iconTheme: const IconThemeData(color: Colors.blueAccent),
            ),
            body: Column(
              children: [
                TextFormField(
                  onChanged: (query) async {
                    context.read<SelectingExercisesCubit>().searchFoods();
                  },
                  controller:
                      context.read<SelectingExercisesCubit>().searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(12),
                        right: Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.exercises.length,
                    itemBuilder: (context, index) {
                      var dark = THelperFunctions.isDarkMode(context);

                      final food = state.exercises[index];
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<SelectingExercisesCubit>()
                              .toggleFoodSelection(food);
                        },
                        child: Card(
                          color: food.isSelected
                              ? Colors.blueAccent.withOpacity(0.5)
                              : null,
                          child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage(
                                      TImages.excersiseDirectory +
                                          food.exerciseImage,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                "${food.usedEquipment} ${food.exerciseName}",
                                style: TextStyle(
                                    color: dark ? Colors.white : Colors.black),
                              ),
                              subtitle: Text(
                                food.targetMuscles,
                                style: TextStyle(
                                    color: dark ? Colors.white : Colors.black),
                              )),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                context
                        .read<SelectingExercisesCubit>()
                        .selectedFoods()
                        .isNotEmpty
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Exercisesassignment(
                            //       routine: routine,
                            //       clientData: clientData,
                            //       selectedExercises: selectedFoods,
                            //     ),
                            //   ),
                            // );
                          },
                          child: const Text("Set Exercises"),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}
