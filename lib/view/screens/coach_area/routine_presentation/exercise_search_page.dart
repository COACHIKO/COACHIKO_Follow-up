import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/coach_controllers/routine_controllers/exercise_search_controller.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import 'exercise_edit_page.dart';

class ExerciseSearchPage extends StatelessWidget {
  final int id;
  final int routineId;
  const ExerciseSearchPage({super.key,required this.id, required this.routineId,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search For Exercises'),
        iconTheme: const IconThemeData(color: CColors.primary), // Set the icon color to blue accent
      ),
      body: GetBuilder<ExerciseSearchPageController>(
        builder: (controller) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  controller.searchController.value = value;
                  controller.filterExercises();
                },
                decoration: const InputDecoration(
                  hintText: 'Search exercises...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: _buildExerciseList(controller),
            ),
            _buildSelectedExercisesButton(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseList(ExerciseSearchPageController controller) {
    if (controller.exercises.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: controller.selectedExercises.length,
        itemBuilder: (context, index) {
          final exercise = controller.selectedExercises[index];
          return SizedBox(
            height: 80,
            child: Center(
              child: Card(
                child: ListTile(
                  subtitle: Text(exercise.targetMuscles),
                  title: Text(exercise.exerciseName),
                  trailing: Checkbox(
                    value: exercise
                        .isSelected, // Use isSelected property from your Exercise model
                    onChanged: (value) {
                      // Handle checkbox value change
                      controller.toggleSelection(index);
                    },
                    activeColor: Colors.blue, // Set active color to blue
                  ),
                  leading: ClipOval(
                    child: Image.asset(
                      TImages.excersiseDirectory + exercise.exerciseImage,
                      width: 50,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Widget _buildSelectedExercisesButton(ExerciseSearchPageController controller) {
    return GetBuilder<ExerciseSearchPageController>(
      builder: (controller) {
        bool hasSelectedExercises(ExerciseSearchPageController controller) {
          return controller.exercises.any((exercise) => exercise.isSelected);
        }

        return hasSelectedExercises(controller)
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 12),
              child: SizedBox(

              width: double.infinity,
              child: ElevatedButton(
              onPressed: () async {
                        Get.to(() =>  EditExercisePage(
                selectedExercises: controller.exercises
                    .where((exercise) => exercise.isSelected)
                    .toList(),id: id.toString(),routineId: routineId.toString()
                        ));

                      },

                    child: const Text("Set Workout Plan"),
                  ),
                  ),
            )
            : const SizedBox();
      },
    );
  }
}
