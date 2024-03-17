import 'package:flutter/material.dart';
import 'package:followupapprefactored/view/screens/coach_area/routine_presentation/exercise_search_page.dart';
import 'package:get/get.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../data/model/routine_models/exercise_model.dart';
import '../../../../data/source/web_services/coach_web_services/coach_assign_exercise_to_routine.dart';

class EditExerciseController extends GetxController {
  final AssignExerciseToRoutine assignExerciseToRoutine = AssignExerciseToRoutine();

  late List<TextEditingController> setsControllers;
  late List<TextEditingController> repsControllers;
  late List<TextEditingController> rirControllers;
  late List<TextEditingController> restControllers;

  @override
  void onInit() {
    super.onInit();
    setsControllers = [];
    repsControllers = [];
    rirControllers = [];
    restControllers = [];
  }

  @override
  void onClose() {
    for (var controller in setsControllers) {
      controller.dispose();
    }
    for (var controller in repsControllers) {
      controller.dispose();
    }
    for (var controller in rirControllers) {
      controller.dispose();
    }
    for (var controller in restControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void initializeControllers(int length) {
    for (var i = 0; i < length; i++) {
      setsControllers.add(TextEditingController());
      repsControllers.add(TextEditingController());
      rirControllers.add(TextEditingController());
      restControllers.add(TextEditingController());
    }
  }

  Future<void> saveExerciseDetails({
    required String num,
    required String id,
    required String routineId,
    required String exerciseId,
    required int index,
  }) async {
    try {
      final int setId = int.tryParse(setsControllers[index].text) ?? 0;
      final int repId = int.tryParse(repsControllers[index].text) ?? 0;
      final int rirId = int.tryParse(rirControllers[index].text) ?? 0;
      final int restId = int.tryParse(restControllers[index].text) ?? 0;

      await assignExerciseToRoutine.assignExerciseToRoutine(
        num,
        id,
        exerciseId,
        setId,
        repId,
        rirId,
        restId,
        routineId,
      );
    } catch (e) {
      //print('Error: $e');
    }
  }
}
class EditExercisePage extends StatelessWidget {
  final List<Exercise> selectedExercises;
  final String id;
  final String routineId;
  final EditExerciseController controller = Get.put(EditExerciseController());

  EditExercisePage({super.key,
    required this.selectedExercises,
    required this.id,
    required this.routineId,
  }) {
    controller.initializeControllers(selectedExercises.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Workout Plan'),
        iconTheme: const IconThemeData(color: CColors.primary),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedExercises.length + 1, // Increment itemCount by 1 for the button
              itemBuilder: (context, index) {
                if (index < selectedExercises.length) {
                  final exercise = selectedExercises[index];
                  return Column(
                    children: [
                      ExpansionTile(
                        title: Text(exercise.exerciseName),
                        subtitle: Text(exercise.targetMuscles),
                        leading: ClipOval(
                          child: Image.asset(
                            TImages.excersiseDirectory + exercise.exerciseImage,
                            width: 50,
                          ),
                        ),
                        children: [
                          _buildExerciseInputFields(exercise, index),
                        ],
                      ),
                    ],
                  );
                } else {
                  // This is the last index, add the button
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0,vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: OutlinedButton(
                        onPressed: () async {
                          Get.to(ExerciseSearchPage(id:int.parse(id), routineId:  int.parse(routineId) ));
                         },
                        child: const Text("Add Exercise"),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 8),
            child:SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  for (int i = 0; i < selectedExercises.length; i++) {
                    final Exercise exercise = selectedExercises[i];
                    await controller.saveExerciseDetails(
                      num: selectedExercises.length.toString(),
                      id: id,
                      routineId: routineId,
                      exerciseId: exercise.exerciseID,
                      index: i,
                    );
                  }
                },

                child: const Text("Set Workout Plan"),
              ),
            ),

          ),
        ],
      ),
    );
  }

  Widget _buildExerciseInputFields(Exercise exercise, int index) {
    final controller = Get.find<EditExerciseController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: const Text('Number of Sets'),
            trailing: SizedBox(
              width: 100,
              child: TextField(
                controller: controller.setsControllers[index],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Sets',
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Number of Reps'),
            trailing: SizedBox(
              width: 100,
              child: TextField(
                controller: controller.repsControllers[index],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Reps',
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Rest Minutes'),
            trailing: SizedBox(
              width: 100,
              child: TextField(
                controller: controller.restControllers[index],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Rest',
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Reps in Reserve'),
            trailing: SizedBox(
              width: 100,
              child: TextField(
                controller: controller.rirControllers[index],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'RIR',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

