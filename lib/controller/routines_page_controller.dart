import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../data/model/exercise_model.dart';
import '../data/model/routine_model.dart';
import '../view/screens/client_area/routine_log_page.dart';

class RoutinesPageController extends GetxController {


  List<Routine> routines = [];

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    openHiveBox();
   }


  Future<void> loadData() async {
    var box = await Hive.openBox<Routine>(hiveBoxName);
    routines.addAll(box.values.toList());
  }


  final String hiveBoxName = 'routines';


  Future<void> openHiveBox() async {
    var appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<Routine>(hiveBoxName);
  }



  Future<Box<Routine>> saveData(List<Routine> routines) async {
    var box = await Hive.openBox<Routine>(hiveBoxName);
    try {
      await box.addAll(routines);
      return box;
    } catch (e) {
      // Handle error if necessary
      print('Error saving data: $e');
      await box.close(); // Close the box in case of error
      rethrow; // Rethrow the error to notify the caller
    }
  }

  Future<void> deleteData() async {
    var box = await Hive.openBox<Routine>(hiveBoxName);
    box.clear();
  }





  void startRoutine(Routine routine) {
    Get.to(
      ExerciseLoggingPage(
        routineName: routine.name,
        exercises: routine.exercises.map((exercise) => exercise.name).toList(),
        setsPerExercise: routine.exercises.map((exercise) => exercise.sets).toList(),
        lastWeights: routine.exercises.map((exercise) => exercise.lastWeight).toList(),
        rest: routine.exercises.map((exercise) => exercise.rest).toList(),
      ),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 500),
    );
  }


}
